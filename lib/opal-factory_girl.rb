[
    'jruby/synchronized',
    'monitor',
    'thread_safe/jruby_cache_backend',
    'atomic',
    'jruby',
    'logger',
    'active_support/deprecation',
    'active_support/core_ext/module/delegation',
    'active_support/notifications',
    'active_support/core_ext/hash/keys',
    'active_support/core_ext/hash/except'
].each { |r| Opal::Processor.stub_file r }


# Just register our opal code path with opal build tools
Opal.append_path File.expand_path('../../opal', __FILE__)
Opal.append_path File.expand_path('../../factory_girl/lib', __FILE__)
require 'opal-activesupport'
