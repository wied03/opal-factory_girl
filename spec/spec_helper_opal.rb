module DefineConstantMacros
  # no tables here
  def create_table(table_name, &block)
  end

  def define_model(name, columns = {}, &block)
    model = define_class(name, ActiveRecord::Base, &block)
    model.class_eval do
      columns.each do |column_name, _|
        puts "adding #{column_name} to #{model}"
        attr_accessor column_name
      end
    end
    # create_table(model.table_name) do |table|
    #   columns.each do |column_name, type|
    #     table.column column_name, type
    #   end
    # end
    model
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

