[
    'mutex_m',
    'jruby/synchronized',
    'monitor',
    'thread_safe/jruby_cache_backend',
    'atomic',
    'jruby',
    'logger',
    'active_support/inflector/methods', # has an incompatible regex in it
].each { |r| Opal::Processor.stub_file r }


# Just register our opal code path with opal build tools
Opal.append_path File.expand_path('../../opal', __FILE__)
Opal.append_path File.expand_path('../../factory_girl/lib', __FILE__)
require 'opal-activesupport'
Opal.use_gem 'activesupport'
