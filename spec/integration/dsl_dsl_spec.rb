# encoding: utf-8
require 'spec_helper'

describe Katuv do
  before do
    Katuv::DSL::Definition.stub(:define)
    Katuv.dsl :SomeDSLNamespace
  end

  specify "Katuv.dsl delegates to Katuv::DSL::Definition" do
    Katuv::DSL::Definition.should have_received(:define).with(:SomeDSLNamespace)
  end
end
