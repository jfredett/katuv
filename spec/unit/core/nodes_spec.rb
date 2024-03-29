# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Nodes do
  subject(:nodes) { Katuv::Core::Nodes.new }

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
    its(:length) { should == 1 }
  end

  describe '#each' do
    let(:example_node) { double :node }

    before { nodes << example_node }

    it "delegates as expected" do
      allow(example_node).to receive(:foo)
      nodes.each do |node|
        node.foo
      end
    end
  end

  describe '#ast' do
    context 'root node ast' do
      before do
        nodes << Katuv::Core::Root.new(:root)
      end

      describe 'the ast' do
        subject(:nodes_ast) { nodes.ast }
        let(:expected_ast) { s(:nodes, *nodes.map(&:ast)) }

        it { should == expected_ast }
      end

      describe 'the node' do
        subject { nodes.last }

        its(:name) { should == :root }
        its(:type) { should == :root }
      end
    end

    context 'nonterminal node ast' do
      before do
        nodes << Katuv::Core::Nonterminal.new(:nonterm)
      end

      describe 'the ast' do
        subject(:nodes_ast) { nodes.ast }
        let(:expected_ast) { s(:nodes, *nodes.map(&:ast)) }

        it { should == expected_ast }
      end

      describe 'the node' do
        subject { nodes.last }

        its(:name) { should == :nonterm }
        its(:type) { should == :nonterminal }
      end
    end

    context 'terminal node ast' do
      before do
        nodes << Katuv::Core::Terminal.new(:term)
      end

      describe 'the ast' do
        subject(:nodes_ast) { nodes.ast }
        let(:expected_ast) { s(:nodes, *nodes.map(&:ast)) }

        it { should == expected_ast }
      end

      describe 'the node' do
        subject { nodes.last }

        its(:name) { should == :term }
        its(:type) { should == :terminal }
      end
    end

    context 'mixed nodeset ast' do
      before do
        nodes << Katuv::Core::Terminal.new(:term1)
        nodes << Katuv::Core::Terminal.new(:term2)
        nodes << Katuv::Core::Nonterminal.new(:nonterm3)
        nodes << Katuv::Core::Root.new(:root)
      end

      describe 'the ast' do
        subject(:nodes_ast) { nodes.ast }
        let(:expected_ast) { s(:nodes, *nodes.map(&:ast)) }

        it { should == expected_ast }
      end

      describe 'the node' do
        its(:length) { should == 4 }
      end
    end
  end

  specify "raise an error if trying to add multiple roots" do
    expect do
      nodes << Katuv::Core::Root.new(:root1)
      nodes << Katuv::Core::Root.new(:root2)
    end.to raise_error Katuv::Core::MultipleRootsError
  end

  specify "do not disallow adding other nodes after adding the root" do
    expect do
      nodes << Katuv::Core::Root.new(:root1)
      nodes << Katuv::Core::Terminal.new(:foo)
    end.to_not raise_error
  end
end
