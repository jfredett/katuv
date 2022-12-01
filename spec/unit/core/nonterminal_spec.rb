# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Node, Katuv::Core::Nonterminal do
  it_behaves_like 'a relatable node called', :nonterminal do
    let(:klass) { Katuv::Core::Nonterminal }
  end

  subject(:nonterminal) { Katuv::Core::Nonterminal.new(:nonterm) }

  before do
    nonterminal.one(:bar)
    nonterminal.many(:foo)
  end

  its(:type) { should == :nonterminal }

  its(:ast) do
    should == \
      s(:nonterminal,
        s(:name, :nonterm),
        s(:associations,
          s(:association,
            s(:name, :bar),
            s(:type, :single),
            s(:optional?, false)),
          s(:association,
            s(:name, :foo),
            s(:type, :many),
            s(:optional?, false))))
  end
end
