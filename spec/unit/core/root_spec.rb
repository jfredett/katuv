# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Node, Katuv::Core::Root do
  it_behaves_like 'a relatable node called', :root do
    let(:klass) { Katuv::Core::Root }
  end

  subject(:root) { Katuv::Core::Root.new(:root) }

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
