module Mutex_m
  def synchronize
    yield
  end
end

require 'active_support/core_ext/module/delegation'
require 'active_support/inflector'
require 'opal/active_support/inflector/methods'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/string'
require 'active_support/notifications/fanout'

class String
  def humanize
    ActiveSupport::Inflector.humanize(self)
  end
end

class ActiveSupport::Inflector::Inflections
  def humans
    @humans ||= []
  end

  def acronyms
    @acronyms ||= {}
  end

  def acronym_regex
    @acronym_regex ||= /(?=a)b/
  end

  def human(rule, replacement)
    @humans.prepend([rule, replacement])
  end

  def acronym(word)
    a = acronyms
    _ = acronym_regex
    a[word.downcase] = word
    @acronym_regex = /#{a.values.join("|")}/
  end
end

module ActiveSupport
  module Notifications
    # This is a default queue implementation that ships with Notifications.
    # It just pushes events to all registered log subscribers.
    #
    # This class is thread safe. All methods are reentrant.
    class Fanout
      #def subscribe(pattern = nil, block = Proc.new)
      # Opal doesn't like block without &block and Proc.new isn't valid anyways
      def subscribe(pattern = nil, &block)
        subscriber = Subscribers.new pattern, block
        synchronize do
          @subscribers << subscriber
          @listeners_for.clear
        end
        subscriber
      end
    end
  end
end

require 'factory_girl'

# Opal didn't seem like like synchronize { super }, so removed sync, probably super w/ args inside a block
module ThreadSafe
  class SynchronizedCacheBackend
    def [](key)
      super
    end

    def []=(key, value)
      super
    end

    def compute_if_absent(key)
      super
    end

    def compute_if_present(key)
      super
    end

    def compute(key)
      super
    end

    def merge_pair(key, value)
      super
    end

    def replace_pair(key, old_value, new_value)
      super
    end

    def replace_if_exists(key, new_value)
      super
    end

    def get_and_set(key, value)
      super
    end

    def key?(key)
      super
    end

    def value?(value)
      super
    end

    def delete(key)
      super
    end

    def delete_pair(key, value)
      super
    end

    def clear
      super
    end

    def size
      super
    end

    def get_or_default(key, default_value)
      super
    end

    private
    def dupped_backend
      super
    end
  end
end

module FactoryGirl
  class Decorator
    class NewConstructor < Decorator
      def build_class_accessor
        @build_class
      end

      # For some reason, the instance_variable_get was not working
      #delegate :new, to: :@build_class
      delegate :new, to: :build_class_accessor
    end
  end
end


module FactoryGirl
  class AttributeAssigner
    def instance_builder_set(&instance_builder)
      @instance_builder = instance_builder
    end
  end

  # @api private
  class Factory
    def run(build_strategy, overrides, &block)
      block ||= ->(result) { result }
      compile

      strategy = StrategyCalculator.new(build_strategy).strategy.new

      evaluator = evaluator_class.new(strategy, overrides.symbolize_keys)
      constr = compiled_constructor
      attribute_assigner = AttributeAssigner.new(evaluator, build_class, &constr)
      # Opal issues with passing a block reference in a constructor
      attribute_assigner.instance_builder_set(&constr)

      evaluation = Evaluation.new(attribute_assigner, compiled_to_create)
      evaluation.add_observer(CallbacksObserver.new(callbacks, evaluator))

      strategy.result(evaluation).tap(&block)
    end
  end
end
