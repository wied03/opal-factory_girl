require 'opal-parser'

class Module
  class DelegationError < NoMethodError;
  end

  DELEGATION_RESERVED_METHOD_NAMES = Set.new(
      %w(_ arg args alias and BEGIN begin block break case class def defined? do
         else elsif END end ensure false for if in module next nil not or redo
         rescue retry return self super then true undef unless until when while
         yield)
  )

  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, 'Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, to: :greeter).'
    end

    prefix, allow_nil = options.values_at(:prefix, :allow_nil)

    if prefix == true && to =~ /^[^a-z_]/
      raise ArgumentError, 'Can only automatically set the delegation prefix when delegating to a method.'
    end

    method_prefix = if prefix
                      "#{prefix == true ? to : prefix}_"
                    else
                      ''
                    end
    to = to.to_s
    to = "self.#{to}" if DELEGATION_RESERVED_METHOD_NAMES.include?(to)

    methods.each do |method|
      # Attribute writer methods only accept one argument. Makes sure []=
      # methods still accept two arguments.
      definition = (method =~ /[^\]]=$/) ? 'arg' : '*args, &block'

      # The following generated method calls the target exactly once, storing
      # the returned value in a dummy variable.
      #
      # Reason is twofold: On one hand doing less calls is in general better.
      # On the other hand it could be that the target has side-effects,
      # whereas conceptually, from the user point of view, the delegator should
      # be doing one call.
      if allow_nil
        method_def = [
            "def #{method_prefix}#{method}(#{definition})",
            "_ = #{to}",
            "if !_.nil? || nil.respond_to?(:#{method})",
            "  _.#{method}(#{definition})",
            "end",
            "end"
        ].join ';'
      else
        exception = %(raise DelegationError, "#{self}##{method_prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: \#{self.inspect}")

        method_def = [
            "def #{method_prefix}#{method}(#{definition})",
            " _ = #{to}",
            "  _.#{method}(#{definition})",
            "rescue NoMethodError => e",
            "  if _.nil? && e.name == :#{method}",
            "    #{exception}",
            "  else",
            "    raise",
            "  end",
            "end"
        ].join ';'
      end

      eval(method_def)
    end
  end
end
