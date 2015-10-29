class BasicFgSpec
  attr_reader :first_name

  def initialize(first_name:)
    @first_name = first_name
  end
end

describe '42' do
  before do
    FactoryGirl.define do
      factory :basic_fg_spec, class: BasicFgSpec do
        first_name 'Joe'

        initialize_with { new(first_name: first_name) }
      end
    end
  end

  subject { FactoryGirl.build(:basic_fg_spec).first_name }

  it { is_expected.to eq 'Joe' }
end
