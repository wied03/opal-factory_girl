require 'progress_json_formatter'

module DefineConstantMacros
  # no tables here
  def create_table(table_name, &block)
  end

  def define_model(name, columns = {}, &block)
    model = define_class(name, ActiveRecord::Base, &block)
    model.class_eval do
      columns.each do |column_name, type|
        if type == :boolean
          define_method("#{column_name}?") { self.send(column_name) }
        end
        attr_accessor column_name
      end

      def write_attribute(attr, value)
        self.instance_variable_set("@#{attr}".to_sym, value)
      end

      def initialize(attr_hash={})
        attr_hash.each do |k, v|
          write_attribute k, v
        end
      end

      def persisted?
        false
      end
    end
    # create_table(model.table_name) do |table|
    #   columns.each do |column_name, type|
    #     table.column column_name, type
    #   end
    # end
    model
  end
end

# Mocha uses protected methods
module Kernel
  alias protected_methods methods
  alias public_method method
end

class Boolean
  def false?
    !self
  end
end

class Mocha::ClassMethod
  def define_new_method
    # definition_target.class_eval(<<-CODE, __FILE__, __LINE__ + 1)
    #         def #{method}(*args, &block)
    #           mocha.method_missing(:#{method}, *args, &block)
    #         end
    # CODE
    # eval not supported on Opal
    method_name = method
    definition_target.class_eval do
      define_method(method_name) do |*args, &block|
        m = self.send(:mocha)
        m.method_missing(method_name, *args, &block)
      end
    end
    if @original_visibility
      Module.instance_method(@original_visibility).bind(definition_target).call(method_name)
    end
  end

  # alias_method :==, :eql? was causing an infinite loop in Opal's == method, so using this for now
  def ==(other)
    self.__id__ == other.__id__
  end
end

class Mocha::Expectation
  def mocha_inspect
    message = "#{@cardinality.mocha_inspect}, "
    # opal string mutation
    message += case @invocation_count
               when 0 then
                 "not yet invoked"
               when 1 then
                 "invoked once"
               when 2 then
                 "invoked twice"
               else
                 "invoked #{@invocation_count} times"
               end
    message += ": "
    message += method_signature
    message += "; #{@ordering_constraints.map { |oc| oc.mocha_inspect }.join("; ")}" unless @ordering_constraints.empty?
    message
  end
end

class Mocha::API::HaveReceived
  def failure_message
    message = ""
    if matching_stubs.empty?
      # opal string mutation
      message += "unstubbed, "
    end
    message + @expectation.mocha_inspect
  end
end

RSpec.configure do |config|
  config.mock_framework = :mocha

  config.include DeclarationMatchers
  #config.full_description = 'FactoryGirl::StrategyCalculator when a symbol returns the strategy found'
  #config.full_description = 'FactoryGirl::Factory factory name with underscores human_names'

  config.after do
    FactoryGirl.reload
  end
end

# deprecated, FG specs use rspec2
def share_examples_for(name, &block)
  RSpec.shared_context(name, &block)
end

# Can't support activerecord in Opal
module ActiveRecord
  class Base
    attr_accessor :id

    def self.establish_connection(*)
    end

    def self.table_name
      self.name
    end

    def self.belongs_to(item)
      attr_accessor item
    end

    def self.has_many(items)
      attr_accessor items
    end

    def new_record?
      id == nil
    end

    def save!
    end

    def [](item)
      self.send(item)
    end
  end
end

module Timecop
  def self.freeze(*)
  end
end

