require 'opal/rspec'
require 'opal-factory_girl'
require_relative 'spec/factory_girl/test_helper'

TestHelper.use_opal_gems
sprockets_env = Opal::RSpec::SprocketsEnvironment.new(spec_pattern=nil, exclude_pattern=nil, files=TestHelper.get_test_files)
sprockets_env.cache = Sprockets::Cache::FileStore.new('tmp/cache')
sprockets_env.default_path = 'spec/factory_girl'
run Opal::Server.new(sprockets: sprockets_env) { |s|
  s.main = 'opal/rspec/sprockets_runner'
  s.append_path 'factory_girl/spec'
  sprockets_env.add_spec_paths_to_sprockets
  s.debug = false
}
