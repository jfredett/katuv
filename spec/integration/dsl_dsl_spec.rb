# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL do
  specify "Katuv.dsl delegates to Katuv::DSL::define" do
    Katuv::DSL.stub(:define)
    Katuv.dsl :SomeDSLNamespace
    Katuv::DSL.should have_received(:define).with(:SomeDSLNamespace)
  end

  describe 'Katuv::DSL.define' do
    let(:definition_block) { proc { shibboleth } }

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
