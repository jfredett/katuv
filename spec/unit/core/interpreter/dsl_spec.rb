# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter::DSL do
  subject(:interpreter) { Katuv::Core::Interpreter::DSL.new }

  describe '#on_dsl' do
    let(:namespace) { double('namespace element') }
    let(:definition_subtree) { double('definition subtree') }
    let(:sexp) { s(:dsl, namespace, definition_subtree ) }

    before do
      interpreter.stub(:process).with(namespace)
      interpreter.stub(:process).with(definition_subtree)
      interpreter.on_dsl(sexp)
    end

    it { should have_received(:process).with(namespace) }
    it { should have_received(:process).with(definition_subtree) }
  end

  describe '#on_namespace' do
    let(:sexp) { s(:namespace, :Foo) }

    it 'creates the namespace module specified by the symbol in the cdr position' do
      Object.const_defined?(:Foo).should be false
      interpreter.on_namespace(sexp)
      Object.const_defined?(:Foo).should be true
      Object.const_get(:Foo).should be_a Module
    end

    after do
      Object.send(:remove_const, :Foo)
    end
  end

  describe '#on_nodes' do
    let(:node_list) { double("dummy sexp") }
    let(:sexp) { s(:nodes, node_list) }
    before do
      interpreter.stub(:process_all).with(node_list)
      interpreter.on_nodes(sexp)
    end

    it { should respond_to :on_nodes }
    it { should have_received(:process_all).with(node_list) }
  end

  describe '#on_terminal'
  describe '#on_nonterminal'
  describe '#on_root'

end
