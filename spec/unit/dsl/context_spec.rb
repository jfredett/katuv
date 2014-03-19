# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Context do
  subject(:example_class) do
    Class.new do
      include Katuv::DSL::Context

      # for testing purposes only, inject some setters
      attr_accessor :children # accessor so that it mimics the API of a Node
      def self.validations=(validations)
        @validations = validations
      end
    end
  end

  describe 'api' do
    describe 'instance api' do
      subject { example_class.new }

      it { should respond_to :valid? }
      it { should respond_to :validations }
    end

    describe 'class api' do
      subject { example_class }

      it { should respond_to :add_validations }
      it { should respond_to :validations }
    end
  end

  describe '.add_validations' do
    let(:validation_1) { double('validation 1') }
    let(:validation_2) { double('validation 2') }


    context 'when given a single, bare element' do
      before { example_class.add_validations(validation_1) }

      its(:validations) { should have(1).element }
      its(:validations) { should =~ [validation_1] }
    end

    context 'when given a list of one element' do
      before { example_class.add_validations([validation_1]) }

      its(:validations) { should have(1).element }
      its(:validations) { should =~ [validation_1] }
    end

    context 'when given a list of several elements' do
      before { example_class.add_validations([validation_1, validation_2]) }

      its(:validations) { should have(2).elements }
      its(:validations) { should =~ [validation_1, validation_2] }
    end

    context 'adding more validations after the fact' do
      before { example_class.add_validations(validation_1) }

      it 'adds the new validations to the list, preserving the old ones' do
        example_class.validations.should have(1).element
        example_class.validations.should =~ [validation_1]

        example_class.add_validations validation_2

        example_class.validations.should have(2).elements
        example_class.validations.should =~ [validation_1, validation_2]
      end
    end

    specify 'return value should be nil' do
      example_class.add_validations(double('anything')).should be_nil
    end
  end

  describe '#valid?' do
    let(:validation) { double('validation') }
    let(:validations) { [validation] }

    let(:child) { double('child') }
    let(:children) { [child] }

    subject(:example_instance) do
      example_class.new.tap do |instance|
        instance.children = children
        instance.class.validations = validations
      end
    end

    describe 'when the validations pass, and the children are valid' do
      before do
        validation.stub(:success?).and_return(true)
        child.stub(:valid?).and_return(true)
      end

      it { should be_valid }
    end

    describe 'when the validations pass, and the children are not valid' do
      before do
        validation.stub(:success?).and_return(true)
        child.stub(:valid?).and_return(false)
      end

      it { should_not be_valid }
    end

    describe 'when the validations pass, and there are no children' do
      before do
        validation.stub(:success?).and_return(true)
        example_instance.children = []
      end

      it { should be_valid }
    end

    describe 'when the validations do not pass' do
      before do
        validation.stub(:success?).and_return(false)
        child.stub(:valid?).and_return(:anything_at_all)
      end

      it { should_not be_valid }
    end

    describe 'when there are no validations, and the children are valid' do
      before do
        example_instance.class.validations = []
        child.stub(:valid?).and_return(true)
      end

      it { should be_valid }
    end

    describe 'when there are no validations, and the children are not valid' do
      before do
        example_instance.class.validations = []
        child.stub(:valid?).and_return(false)
      end

      it { should_not be_valid }
    end

    describe 'when there are no validations, and there are no children' do
      before do
        example_instance.class.validations = []
        example_instance.children = []
      end

      it { should be_valid }
    end
  end
end
