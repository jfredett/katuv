# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Nonterminal do
  it_behaves_like 'a relatable node called', :nonterminal do
    let(:klass) { Katuv::DSL::Nonterminal }
  end

  subject(:nonterminal) { Katuv::DSL::Nonterminal.new(:nonterm) }

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
