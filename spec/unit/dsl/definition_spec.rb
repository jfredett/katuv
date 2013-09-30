# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Definition do
  let(:block) { proc { shibboleth } }
  subject(:definition) { Katuv::DSL::Definition.new(:SomeNamespace) }

  describe 'api of the returned object' do
    it { should respond_to :terminal }
    it { should respond_to :nonterminal }
    it { should respond_to :root }
    it { should respond_to :evaluate! }
    it { should respond_to :nodes }
    it { should respond_to :namespace }
    it { should respond_to :type }
  end

  describe '#namespace' do
    its(:namespace) { should == :SomeNamespace }
  end
  its(:type) { should == :definition }

  describe '#evaluate!' do
    before do
      definition.stub(:shibboleth)
      definition.evaluate!(&block)
    end

    it { should have_received :shibboleth }

    specify { expect { definition.evaluate! }.to raise_error ArgumentError, "must supply block" }
  end

  describe '#terminal' do
    it_should_behave_like 'a definition node called', :terminal do
      let(:klass) { Katuv::DSL::Terminal }
    end
  end

  describe '#nonterminal' do
    it_should_behave_like 'a definition node called', :nonterminal do
      let(:klass) { Katuv::DSL::Nonterminal }
    end
  end

  describe '#root' do
    it_should_behave_like 'a definition node called', :root do
      let(:klass) { Katuv::DSL::Root }
    end
  end
end
