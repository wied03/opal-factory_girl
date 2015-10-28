require 'factory_girl/version'

module Opal
  module FactoryGirl
    # Add a minor version to the end in case there are opal specific issues to fix
    VERSION = "#{::FactoryGirl::VERSION}.1"
  end
end
