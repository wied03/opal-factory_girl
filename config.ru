require 'opal/rspec'
require 'opal-factory_girl'

[
    # 'rubygems',
    # 'simplecov',
    # 'bourne',
    # 'timecop',
    'spec_helper',
    'active_record',
    'aruba/cucumber'
].each { |r| Opal::Processor.stub_file r }
Opal.use_gem 'mocha'
files = FileList['spec/basic_requires.rb',
                 'factory_girl/spec/support/**/*.rb',
                 'spec/spec_helper_opal.rb',
                 'spec/**/*_spec.rb',
                 'factory_girl/spec/**/*_spec.rb']
puts "Files are #{files}"
sprockets_env = Opal::RSpec::SprocketsEnvironment.new(spec_pattern=nil, exclude_pattern=nil, files=files)
run Opal::Server.new(sprockets: sprockets_env) { |s|
      s.main = 'opal/rspec/sprockets_runner'
      s.append_path 'factory_girl/spec'
      sprockets_env.add_spec_paths_to_sprockets
      s.debug = false
    }
