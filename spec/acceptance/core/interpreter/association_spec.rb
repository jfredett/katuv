# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter::Association do
  subject(:interpreter) { Katuv::Core::Interpreter::Association.new }

  let(:example_associations_ast) do
    s(:association,
      s(:name, :Baz),
      s(:type, :single),
      s(:optional?, true))
  end

  before { interpreter.process(example_associations_ast) }

  its(:name) { should == :Baz }
  its(:type) { should == :single }
  its(:optional?) { should be true }
end
