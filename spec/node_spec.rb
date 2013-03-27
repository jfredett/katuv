require 'spec_helper'

describe Katuv::Node do
  before :all do
    class ExampleTerminal
      include Katuv::Node
      terminal!
    end

    class ExampleNonterminal
      include Katuv::Node

      terminal ExampleTerminal
      nonterminal ExampleNonterminal
    end

    class Example
      include Katuv::Node
      terminal ExampleTerminal
      nonterminal ExampleNonterminal
    end
  end
  after :all do
    Object.send(:remove_const, :Example)
    Object.send(:remove_const, :ExampleTerminal)
    Object.send(:remove_const, :ExampleNonterminal)
  end

  describe 'Example' do
    subject { Example.new }
    it_should_behave_like 'a namable class'
    it_should_behave_like 'a class with the naming behavior'
    it_should_behave_like 'a visitable class'
    it_should_behave_like 'a class with the visitable behavior'

    its(:method_name) { should == "example" }
  end

  describe 'ExampleTerminal' do
    subject { ExampleTerminal.new }

    it_should_behave_like 'a namable class'
    it_should_behave_like 'a class with the naming behavior'
    it_should_behave_like 'a visitable class'
    it_should_behave_like 'a class with the visitable behavior'

    its(:method_name) { should == "example_terminal" }

    it { should be_terminal }
  end

  describe 'ExampleNonterminal' do
    subject { ExampleNonterminal.new }

    it_should_behave_like 'a namable class'
    it_should_behave_like 'a class with the naming behavior'
    it_should_behave_like 'a visitable class'
    it_should_behave_like 'a class with the visitable behavior'

    its(:method_name) { should == "example_nonterminal" }
  end
end
