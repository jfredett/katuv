# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter::Node do
  subject(:interpreter) { Katuv::Core::Interpreter::Node.new }

  describe 'root node' do
    let(:sexp) do
      s(:root,
        s(:name, :dsl),
        s(:associations,
          s(:association,
            s(:name, :Foo),
            s(:type, :many),
            s(:optional?, false))))
    end
    before { interpreter.process(sexp) }

    its(:type) { should == :root }
    its(:name) { should == :dsl }
    it { should have(1).associations }

    describe 'the association' do
      subject { interpreter.associations.first }

      its(:name) { should == :Foo }
      its(:type) { should == :many }
      it { should_not be_optional }
      it { should be_required }
    end
  end

  describe 'terminal node' do
    let(:sexp) { s(:terminal, s(:name, :Foo)) }
    before { interpreter.process(sexp) }

    its(:name) { should == :Foo }
    its(:type) { should == :terminal }
    it { should_not have associations }
  end

  describe 'nonterminal node' do
    let(:sexp) do
      s(:nonterminal,
        s(:name, :Baz),
        s(:associations,
          s(:association,
            s(:name, :Foo),
            s(:type, :single),
            s(:optional?, false)),
          s(:association,
            s(:name, :Bar),
            s(:type, :single),
            s(:optional?, true))))
    end
    before { interpreter.process(sexp) }

    its(:type) { should == :nonterminal }
    its(:name) { should == :Baz }
    it { should have(2).associations }

    describe 'the associations' do
      context 'the first association' do
        subject { interpreter.associations[0] }

        its(:name) { should == :Foo }
        its(:type) { should == :single }
        it { should_not be_optional }
        it { should be_required }
      end

      context 'the second association' do
        subject { interpreter.associations[1] }

        its(:name) { should == :Foo }
        its(:type) { should == :single }
        it { should be_optional }
        it { should_not be_required }
      end
    end
  end
end
