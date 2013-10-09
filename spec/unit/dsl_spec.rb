# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL do
  describe 'api' do
    it { should respond_to :parse!     }
    it { should respond_to :define     }
  end

  describe '#parse!' do
    let(:definition) { double('definition of a dsl') }

    before do
      definition.stub(:ast).and_return([])
    end

    subject(:definition_ast) { Katuv::DSL.parse!(definition) }

    specify "calls out to the definition to get it's ast" do
      definition_ast # parse the dsl definition
      definition.should have_received(:ast)
    end

    it { should == s(:dsl) }
  end
end
