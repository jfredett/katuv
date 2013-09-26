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
    it { should respond_to :namespace }
  end

  describe '#namespace' do
    its(:namespace) { should == :SomeNamespace }
  end

  describe '#evaluate!' do
    before do
      definition.stub(:shibboleth)
      definition.evaluate!(&block)
    end

    it { should have_received :shibboleth }

    specify { expect { definition.evaluate! }.to raise_error ArgumentError, "must supply block" }
  end

  describe '#terminal' do
    subject(:terminal) { definition.terminal(:foo) }

    specify { expect { definition.terminal }.to raise_error ArgumentError, "method 'terminal': given 0, expected 1" }

    it { should respond_to :many }
    it { should respond_to :one }
    it { should respond_to :maybe_one }
    it { should respond_to :maybe_many }

    # these are integration-y
    it 'calls the block on the created terminal instance' do
      Katuv::DSL::Terminal.any_instance.should_receive(:shibboleth)
      definition.terminal(:SomeName, &block)
    end

    it 'just returns the instance if no block is given' do
      Katuv::DSL::Terminal.any_instance.should_not_receive(:shibboleth)
      definition.terminal(:SomeName)
    end
  end

  describe '#nonterminal' do
    subject(:nonterminal) { definition.terminal(:foo) }

    specify { expect { definition.nonterminal }.to raise_error ArgumentError, "method 'nonterminal': given 0, expected 1" }

    it { should respond_to :many }
    it { should respond_to :one }
    it { should respond_to :maybe_one }
    it { should respond_to :maybe_many }

    # these are integration-y
    it 'calls the block on the created nonterminal instance' do
      Katuv::DSL::Nonterminal.any_instance.should_receive(:shibboleth)
      definition.nonterminal(:SomeName, &block)
    end

    it 'just returns the instance if no block is given' do
      Katuv::DSL::Nonterminal.any_instance.should_not_receive(:shibboleth)
      definition.nonterminal(:SomeName)
    end
  end

  describe '#root' do
    subject(:root) { definition.terminal(:foo) }

    specify { expect { definition.root }.to raise_error ArgumentError, "method 'root': given 0, expected 1" }

    it { should respond_to :many }
    it { should respond_to :one }
    it { should respond_to :maybe_one }
    it { should respond_to :maybe_many }

    # these are integration-y
    it 'calls the block on the created root instance' do
      Katuv::DSL::Root.any_instance.should_receive(:shibboleth)
      definition.root(:SomeName, &block)
    end

    it 'just returns the instance if no block is given' do
      Katuv::DSL::Root.any_instance.should_not_receive(:shibboleth)
      definition.root(:SomeName)
    end
  end
end
