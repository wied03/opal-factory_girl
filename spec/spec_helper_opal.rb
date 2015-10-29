module DefineConstantMacros
  # no tables here
  def create_table(table_name, &block)
  end
end

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
  class Base
    def self.establish_connection(*)
    end

    def self.table_name
      self.name
    end
  end
end

