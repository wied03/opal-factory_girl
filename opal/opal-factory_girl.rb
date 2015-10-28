require 'opal/corelib/module'

module Mutex_m
  def synchronize
    yield
  end
end

require 'active_support/core_ext/string'
require 'active_support/inflector'
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
