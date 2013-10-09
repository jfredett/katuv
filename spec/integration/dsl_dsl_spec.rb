# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL do
  let(:definition_block) { proc { shibboleth } }

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
