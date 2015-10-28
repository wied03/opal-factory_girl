# -*- encoding: utf-8 -*-
require File.expand_path('../lib/opal/factory_girl/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'opal-factory_girl'
  s.version = Opal::FactoryGirl::VERSION
  s.author = 'Brady Wied'
  s.email = 'brady@bswtechconsulting.com'
  s.summary = 'Allows command line control over Opal-RSpec formatters'
  s.description = 'Allows controlling what formatter the opal-rspec Rake task uses, includes JUnit and TeamCity formtter patches'
  s.homepage = 'https://github.com/wied03/opal-rspec-formatter'

  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('opal/**/*.rb')

  s.require_paths = ['lib']

  s.add_dependency 'factory-girl', '~> 4.5'
end
