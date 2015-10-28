# -*- encoding: utf-8 -*-
# Not using use_gem because we don't want the RSpec dependencies rspec_junit_formatter has
$: << File.expand_path('../factory_girl/lib', __FILE__)
require File.expand_path('../lib/opal/factory_girl/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'opal-factory_girl'
  s.version = Opal::FactoryGirl::VERSION
  s.author = 'Brady Wied'
  s.email = 'brady@bswtechconsulting.com'
  s.summary = 'Allows command line control over Opal-RSpec formatters'
  s.description = 'Allows controlling what formatter the opal-rspec Rake task uses, includes JUnit and TeamCity formtter patches'
  s.homepage = 'https://github.com/wied03/opal-rspec-formatter'

  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('opal/**/*.rb') + Dir.glob('factory_girl/lib/**/*.rb')

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'opal-activesupport'
  s.add_runtime_dependency 'opal', '>= 0.9.0.beta1'

  s.require_paths = ['lib']
end
