module TestHelper
  def self.use_opal_gems
    %w(mocha rspec-its bourne).each { |gem| Opal.use_gem gem }
  end

  def self.get_test_files
    [
      # 'rubygems',
      # 'simplecov',
      # 'bourne',
      # 'timecop',
      'spec_helper', # we have our own copy of this
      'active_record',
      'aruba/cucumber',
      'mocha/object' # we have api/ but sprockets will catch this in rspec adapter
    ].each { |r| Opal::Processor.stub_file r }
    FileList[
      'spec/factory_girl/basic_requires.rb',
      'factory_girl/spec/support/**/*.rb',
      'spec/factory_girl/spec_helper_opal.rb',
      'spec/factory_girl/**/*_spec.rb',
      'factory_girl/spec/**/*_spec.rb'
    ]
  end
end
