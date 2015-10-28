require 'opal/corelib/module'

describe Module do
  describe '#delegate' do
    context 'single method' do
      let(:delegator_klass) do
        Struct.new(:something) do
          delegate :foo, to: :something
        end
      end

      let(:delegatee_klass) do
        Struct.new(:foo)
      end

      let(:delegatee_instance) { delegatee_klass.new 42 }
      let(:delegator_instance) { delegator_klass.new(delegatee_instance) }

      subject { delegator_instance.foo }

      it { is_expected.to eq 42 }
    end

    context 'multiple calls' do
      let(:delegator_klass) do
        Struct.new(:something, :else) do
          delegate :foo, to: :something
          delegate :bar, to: :else
        end
      end

      let(:delegatee_klass) do
        Struct.new(:foo, :bar)
      end

      let(:delegatee_instance1) { delegatee_klass.new 42, 43 }
      let(:delegatee_instance2) { delegatee_klass.new 44, 45 }
      let(:delegator_instance) { delegator_klass.new(delegatee_instance1, delegatee_instance2) }

      subject { delegator_instance }

      it { is_expected.to have_attributes foo: 42,
                                          bar: 45 }
    end

    context 'multiple at once' do
      let(:delegator_klass) do
        Struct.new(:something) do
          delegate :foo, :bar, to: :something
        end
      end

      let(:delegatee_klass) do
        Struct.new(:foo, :bar)
      end

      let(:delegatee_instance) { delegatee_klass.new 42, 43 }
      let(:delegator_instance) { delegator_klass.new(delegatee_instance) }

      subject { delegator_instance }

      it { is_expected.to have_attributes foo: 42,
                                          bar: 43 }
    end

    context 'prefixes' do
      let(:delegator_klass) do
        Struct.new(:something) do
          delegate :foo, to: :something, prefix: true
        end
      end

      let(:delegatee_klass) do
        Struct.new(:foo)
      end

      let(:delegatee_instance) { delegatee_klass.new 42 }
      let(:delegator_instance) { delegator_klass.new(delegatee_instance) }

      subject { delegator_instance.something_foo }

      it { is_expected.to eq 42 }
    end

    context 'nil method' do
      let(:delegator_klass) do
        Struct.new(:something) do
          delegate :foo, to: :something
        end
      end

      let(:delegator_instance) { delegator_klass.new(nil) }

      subject { lambda { delegator_instance.foo } }

      it { is_expected.to raise_error DelegationError, 'foo' }
    end

    xcontext 'allow nil' do
      let(:delegator_klass) do
        Struct.new(:something) do
          delegate :foo, to: :something, allow_nil: true
        end
      end

      let(:delegator_instance) { delegator_klass.new(nil) }

      subject { delegator_instance.foo }

      it { is_expected.to be_nil }
    end
  end
end
