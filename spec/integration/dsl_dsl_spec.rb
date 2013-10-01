# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL do
  let(:definition_block) { proc { shibboleth } }

  describe 'Katuv.dsl' do
    it "delegates to Katuv::DSL::define" do
      Katuv::DSL.stub(:define)
      Katuv.dsl :SomeDSLNamespace, &definition_block
      Katuv::DSL.should have_received(:define).with(:SomeDSLNamespace, &definition_block)
    end

    it "raises an error if you don't pass a block along" do
      expect { Katuv.dsl :SomeDSLNamespace }.to raise_error Katuv::DSL::NoDefinitionBlock
    end
  end

  describe 'Katuv::DSL.define' do
    it 'creates a Katuv::DSL::Definition and #evaluate! the given block on it' do
      Katuv::DSL::Definition.any_instance.should_receive(:shibboleth)
      Katuv::DSL.define(:SomeDSLNamespace, &definition_block).should be_a Katuv::DSL::Definition
    end

    it 'creates a Katuv::DSL::Definition' do
      Katuv::DSL::Definition.any_instance.should_not_receive(:shibboleth)
      Katuv::DSL.define(:SomeDSLNamespace).should be_a Katuv::DSL::Definition
    end
  end
end
