# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Nodes do
  subject(:nodes) { Katuv::DSL::Nodes.new }

  describe 'api' do
    it { should respond_to :<< }
    it { should respond_to :each }
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
