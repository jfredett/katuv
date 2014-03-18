require 'spec_helper'

describe Katuv::DSL::Validator::Factory do
  describe '#build' do
    let(:fake_assoc) { double('assoc') }
    before { fake_assoc.stub(:name).and_return(:example_association_name) }

    subject(:factory) { Katuv::DSL::Validator::Factory.build(fake_assoc) }

    context 'when the association is not unique but is required' do
      before do
        fake_assoc.stub(:required?).and_return(true)
        fake_assoc.stub(:type).and_return(:multiple)
      end

      it { should have(1).element }
      its(:first) { should be_a Katuv::DSL::Validator::RequiredAssociation }
    end

    context 'when the association is unique but not required' do
      before do
        fake_assoc.stub(:required?).and_return(false)
        fake_assoc.stub(:type).and_return(:single)
      end

      it { should have(1).element }
      its(:first) { should be_a Katuv::DSL::Validator::UniqueAssociation }
    end

    context 'when the association is required and unique' do
      before do
        fake_assoc.stub(:required?).and_return(true)
        fake_assoc.stub(:type).and_return(:single)
      end

      it { should have(2).elements }

      describe 'the first element' do
        subject { factory[0] }
        it { should be_a Katuv::DSL::Validator::RequiredAssociation }
      end

      describe 'the second element' do
        subject { factory[1] }
        it { should be_a Katuv::DSL::Validator::UniqueAssociation }
      end
    end

    context 'when the association is neither required nor unique' do
      before do
        fake_assoc.stub(:required?).and_return(false)
        fake_assoc.stub(:type).and_return(:multiple)
      end
      it { should be_empty }
    end
  end
end
