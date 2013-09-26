# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Definition do
  subject(:definition) { Katuv::DSL::Definition.new(:SomeNamespace) }

  describe 'api of the returned object' do
    it { should respond_to :terminal }
    it { should respond_to :nonterminal }
    it { should respond_to :root }
    it { should respond_to :evaluate! }
    it { should respond_to :namespace }
  end

  describe '#namespace' do
    its(:namespace) { should == :SomeNamespace }
  end

  describe '#evaluate!' do
    let(:block) { proc { shibboleth } }

    before do
      definition.stub(:shibboleth)
      definition.evaluate!(&block)
    end

    it { should have_received :shibboleth }

    specify { expect { definition.evaluate! }.to raise_error ArgumentError, "must supply block" }
  end

  describe '#terminal' do
    subject { definition.terminal(:foo) }

    specify { expect { definition.terminal }.to raise_error ArgumentError, "method 'terminal': given 0, expected 1" }

    it { should respond_to :many }
    it { should respond_to :one }
    it { should respond_to :maybe_one }
    it { should respond_to :maybe_many }
  end
end
