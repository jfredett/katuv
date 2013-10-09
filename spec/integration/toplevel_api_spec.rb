# encoding: utf-8
require 'spec_helper'

describe Katuv do
  let(:definition_block) { proc { shibboleth } }

  describe '.dsl' do
    it "delegates to Katuv::DSL::define" do
      Katuv::DSL.stub(:define)
      Katuv.dsl :SomeDSLNamespace, &definition_block
      Katuv::DSL.should have_received(:define).with(:SomeDSLNamespace, &definition_block)
    end

    it "raises an error if you don't pass a block along" do
      expect { Katuv.dsl :SomeDSLNamespace }.to raise_error Katuv::DSL::NoDefinitionBlock
    end
  end
end
