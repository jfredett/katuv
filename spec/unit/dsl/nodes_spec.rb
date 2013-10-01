# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Nodes do
  subject(:nodes) { Katuv::DSL::Nodes.new }

  describe 'api' do
    it { should respond_to :ast }
    it { should respond_to :<< }
    it { should respond_to :each }
  end

  describe '#<<' do
    let(:example_node) { double :node }

    before do
      nodes << example_node
    end

    it { should include example_node }
    it { should have(1).element }
  end

  describe '#each' do
    let(:example_node) { double :node }

    before { nodes << example_node }

    it "delegates as expected" do
      example_node.should_receive(:foo)
      nodes.each do |node|
        node.foo
      end
    end
  end

  describe '#ast' do
    context 'root node ast' do
      before do
        nodes << Katuv::DSL::Root.new(:root)
      end

      subject(:nodes_ast) { nodes.ast }
      let(:expected_ast) { s(:nodes, *nodes.map { |n| n.ast }) }

      it { should == expected_ast }
    end

    context 'nonterminal node ast' do
      before do
        nodes << Katuv::DSL::Nonterminal.new(:nonterm)
      end

      subject(:nodes_ast) { nodes.ast }
      let(:expected_ast) { s(:nodes, *nodes.map { |n| n.ast }) }

      it { should == expected_ast }
    end

    context 'terminal node ast' do
      before do
        nodes << Katuv::DSL::Terminal.new(:term)
      end

      subject(:nodes_ast) { nodes.ast }
      let(:expected_ast) { s(:nodes, *nodes.map { |n| n.ast }) }

      it { should == expected_ast }
    end

    context 'mixed nodeset ast' do
      before do
        nodes << Katuv::DSL::Terminal.new(:term1)
        nodes << Katuv::DSL::Terminal.new(:term2)
        nodes << Katuv::DSL::Nonterminal.new(:nonterm3)
        nodes << Katuv::DSL::Root.new(:root)
      end

      subject(:nodes_ast) { nodes.ast }
      let(:expected_ast) { s(:nodes, *nodes.map { |n| n.ast }) }

      it { should == expected_ast }
    end
  end

  specify "raise an error if trying to add multiple roots" do
    expect do
      nodes << Katuv::DSL::Root.new(:root1)
      nodes << Katuv::DSL::Root.new(:root2)
    end.to raise_error Katuv::DSL::MultipleRootsError
  end

  specify "do not disallow adding other nodes after adding the root" do
    expect do
      nodes << Katuv::DSL::Root.new(:root1)
      nodes << Katuv::DSL::Terminal.new(:foo)
    end.to_not raise_error
  end
end
