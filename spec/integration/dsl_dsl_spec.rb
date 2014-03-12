# encoding: utf-8
require 'spec_helper'

describe Katuv::Core do
  describe 'api' do
    it { should respond_to :parse!     }
    it { should respond_to :compile!   }
    it { should respond_to :interpret! }
  end

  let(:definition_block) { proc { shibboleth } }

  describe 'Katuv::Core.define' do
    it 'creates a Katuv::Core::Definition and #evaluate! the given block on it' do
      Katuv::Core::Definition.any_instance.should_receive(:shibboleth)
      Katuv::Core.define(:SomeDSLNamespace, &definition_block).should be_a Katuv::Core::Definition
    end

    it 'creates a Katuv::Core::Definition' do
      Katuv::Core::Definition.any_instance.should_not_receive(:shibboleth)
      Katuv::Core.define(:SomeDSLNamespace).should be_a Katuv::Core::Definition
    end
  end
end
