class Module
  class DelegationError < NoMethodError;
  end

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

    methods.each do |method|
      # Attribute writer methods only accept one argument. Makes sure []=
      # methods still accept two arguments.
      has_block = (method =~ /[^\]]=$/) ? false : true
      method_name = method_prefix + method
      if has_block
        define_method(method_name) do |*args, &block|
          to_resolved = self.send(to)
          unless to_resolved
            next if allow_nil
            raise DelegationError, "#{self}#{method_name} delegated to #{to}.#{method} but #{to} is nil: #{self.inspect}"
          end
          to_resolved.send(method, *args, &block)
        end
      else
        define_method(method_name) do |arg|
          to_resolved = self.send(to)
          unless to_resolved
            next if allow_nil
            raise DelegationError, "#{self}#{method_name} delegated to #{to}.#{method} but #{to} is nil: #{self.inspect}"
          end
          to_resolved.send(method, arg)
        end
      end
    end
  end
end
