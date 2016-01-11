# -*- encoding: utf-8 -*-
$: << File.expand_path('../factory_girl/lib', __FILE__)
require File.expand_path('../lib/opal/factory_girl/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'opal-factory_girl'
  s.version = Opal::FactoryGirl::VERSION
  s.author = 'Brady Wied'
  s.email = 'brady@bswtechconsulting.com'
  s.summary = 'Opal compatible FactoryGirl'
  s.description = 'Makes necessary patches to FactoryGirl such that it runs on Opal, with some limitations'
  s.homepage = 'https://github.com/wied03/opal-factory_girl'

  s.files = Dir.glob('lib/**/*.rb') + Dir.glob('opal/**/*.rb') + Dir.glob('factory_girl/lib/**/*.rb')

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'opal-activesupport', '~> 0.3'
  s.add_runtime_dependency 'opal', '>= 0.9.0.beta1'

  s.require_paths = ['lib']
end
