Bundler::GemHelper.install_tasks

require 'opal/rspec/rake_task'
require 'opal-factory_girl'
require_relative 'spec/test_helper'

TestHelper.use_opal_gems
Opal::RSpec::RakeTask.new(:default) do |server, task|
  task.files = TestHelper.get_test_files
  server.append_path 'factory_girl/spec'
end
