# encoding: utf-8
require 'spec_helper'

describe Katuv do
  before do
    Katuv::DSL.stub(:define)
    Katuv.dsl :SomeDSLNamespace
  end

  describe "Katuv::DSL api" do
    specify { Katuv::DSL.should respond_to :define }
  end

  specify "Katuv.dsl delegates to Katuv::DSL::Definition" do
    Katuv::DSL.should have_received(:define).with(:SomeDSLNamespace)
  end
end
