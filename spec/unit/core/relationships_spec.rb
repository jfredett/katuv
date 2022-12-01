# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Relationships do
  subject(:relationships) { Katuv::Core::Relationships.new }

  describe 'api' do
    it { should respond_to :<< }
    it { should respond_to :each }
    it { should respond_to :ast }
  end

  describe '#<<' do
    let(:example_relationship) { double :relationship }

    before do
      relationships << example_relationship
    end

    it { should include example_relationship }
    its(:length) { should eq 1 }
    its(:last) { should == example_relationship }
  end

  describe '#each' do
    let(:example_relationship) { double :relationship }

    before { relationships << example_relationship }

    it "delegates as expected" do
      allow(example_relationship).to receive(:foo)
      relationships.each do |relationship|
        relationship.foo
      end
    end
  end

  describe '#ast' do
    context 'nonoptional many relationship' do
      let(:example_relationship) { Katuv::Core::Relationship.many(:relationship) }
      before { relationships << example_relationship }

      specify { should include example_relationship }
      describe 'the added relationship' do
        subject { relationships.last }
        its(:type) { should == :many }
        its(:name) { should == :relationship }
        it { should_not be_optional }
      end

      describe 'the ast' do
        subject { relationships.ast }
        it "generates the AST as expected" do
          should == \
            s(:associations,
              s(:association,
                s(:name, :relationship),
                s(:type, :many),
                s(:optional?, false)))
        end
      end
    end

    context 'optional many relationship' do
      let(:example_relationship) { Katuv::Core::Relationship.maybe_many(:relationship) }
      before { relationships << example_relationship }


      specify { should include example_relationship }
      describe 'the added relationship' do
        subject { relationships.last }
        its(:type) { should == :many }
        its(:name) { should == :relationship }
        it { should be_optional }
      end

      describe 'the ast' do
        subject { relationships.ast }
        it "generates the AST as expected" do
          should == \
            s(:associations,
              s(:association,
                s(:name, :relationship),
                s(:type, :many),
                s(:optional?, true)))
        end
      end
    end

    context 'nonoptional single relationship' do
      let(:example_relationship) { Katuv::Core::Relationship.one(:relationship) }
      before { relationships << example_relationship }

      specify { should include example_relationship }
      describe 'the added relationship' do
        subject { relationships.last }
        its(:type) { should == :single }
        its(:name) { should == :relationship }
        it { should_not be_optional }
      end

      describe 'the ast' do
        subject { relationships.ast }
        it "generates the AST as expected" do
          should == \
            s(:associations,
              s(:association,
                s(:name, :relationship),
                s(:type, :single),
                s(:optional?, false)))
        end
      end
    end

    context 'optional single relationship' do
      let(:example_relationship) { Katuv::Core::Relationship.maybe_one(:relationship) }
      before { relationships << example_relationship }

      specify { should include example_relationship }
      describe 'the added relationship' do
        subject { relationships.last }
        its(:type) { should == :single }
        its(:name) { should == :relationship }
        it { should be_optional }
      end

      describe 'the ast' do
        subject { relationships.ast }
        it "generates the AST as expected" do
          should == \
            s(:associations,
              s(:association,
                s(:name, :relationship),
                s(:type, :single),
                s(:optional?, true)))
        end
      end
    end
  end
end
