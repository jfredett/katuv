# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Root do
  it_behaves_like 'a relatable node called', :root do
    let(:klass) { Katuv::DSL::Root }
  end

  subject(:root) { Katuv::DSL::Root.new(:root) }

  before do
    root.many(:foo)
    root.one(:bar)
  end

  its(:type) { should == :root }

  its(:ast) do
    should == \
      s(:root,
        s(:name, :root),
        s(:associations,
          s(:association,
            s(:name, :foo),
            s(:type, :many),
            s(:optional?, false)),
          s(:association,
            s(:name, :bar),
            s(:type, :single),
            s(:optional?, false))))
  end
end
