class BasicFgSpec
  attr_reader :first_name

  def initialize(first_name:)
    @first_name = first_name
  end
end

class OtherFgSpec
  attr_accessor :basic_fg_spec
end

describe '42' do
  before do
    FactoryGirl.define do
      factory :basic_fg_spec, class: BasicFgSpec do
        skip_create
        
        first_name 'Joe'

        initialize_with { new(first_name: first_name) }
      end

      factory :other, class: OtherFgSpec do
        basic_fg_spec
      end
    end
  end

  context 'string attr' do
    subject { FactoryGirl.build(:basic_fg_spec).first_name }

    it { is_expected.to eq 'Joe' }
  end

  context 'association' do
    subject { FactoryGirl.build(:other).basic_fg_spec.first_name }

    it { is_expected.to eq 'Joe' }
  end
end
