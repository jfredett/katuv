# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Relationship do
  describe 'api' do
    subject { Katuv::Core::Relationship.new(nil, nil) }

    context 'class' do
      its(:class) { should respond_to :many       }
      its(:class) { should respond_to :maybe_many }
      its(:class) { should respond_to :one        }
      its(:class) { should respond_to :maybe_one  }
    end

    context 'instance' do
      it { should respond_to :type }
      it { should respond_to :name }
      it { should respond_to :optional? }
      it { should respond_to :ast }
      its(:optional?) { should be false }
    end
  end

  describe 'many relationship' do
    subject(:relation) { Katuv::Core::Relationship.many(:RelationshipName) }

    its(:type) { should == :many }
    its(:name) { should == :RelationshipName }
    it { should_not be_optional }

    specify do
      expect(relation.ast).to eq s(:association,
                                   s(:name, :RelationshipName),
                                   s(:type, :many),
                                   s(:optional?, false))
    end
  end

  describe 'maybe many relationship' do
    subject(:relation) { Katuv::Core::Relationship.maybe_many(:RelationshipName) }

    its(:type) { should == :many }
    its(:name) { should == :RelationshipName }
    it { should be_optional }

    specify do
      expect(relation.ast).to eq s(:association,
                                   s(:name, :RelationshipName),
                                   s(:type, :many),
                                   s(:optional?, true))
    end
  end

  describe 'one relationship' do
    subject(:relation) { Katuv::Core::Relationship.one(:RelationshipName) }

    its(:type) { should == :single }
    its(:name) { should == :RelationshipName }
    it { should_not be_optional }

    specify do
      expect(relation.ast).to eq s(:association,
                                   s(:name, :RelationshipName),
                                   s(:type, :single),
                                   s(:optional?, false))
    end
  end

  describe 'maybe one relationship' do
    subject(:relation) { Katuv::Core::Relationship.maybe_one(:RelationshipName) }

    its(:type) { should == :single }
    its(:name) { should == :RelationshipName }
    it { should be_optional }

    specify do
      expect(relation.ast).to eq s(:association,
                                   s(:name, :RelationshipName),
                                   s(:type, :single),
                                   s(:optional?, true))
    end
  end
end

RSpec.describe Katuv::Core::OptionalRelationship do
  subject { Katuv::Core::OptionalRelationship.new(nil, nil) }
  its(:optional?) { should be true }
end
