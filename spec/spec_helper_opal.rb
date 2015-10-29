RSpec.configure do |config|
  config.mock_framework = :mocha

  config.include DeclarationMatchers

  config.after do
    FactoryGirl.reload
  end
end

# deprecated, FG specs use rspec2
def share_examples_for(name, &block)
  RSpec.shared_context(name, &block)
end

# Can't support activerecord in Opal
module ActiveRecord
  module Base
    def self.establish_connection(*)
    end
  end
end
