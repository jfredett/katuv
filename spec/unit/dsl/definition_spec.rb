# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Definition do
  subject(:definition) { Katuv::DSL::Definition.new(:SomeNamespace) }

  describe 'api of the returned object' do
    it { should respond_to :terminal }
    it { should respond_to :nonterminal }
    it { should respond_to :root }
    it { should respond_to :evaluate! }
  end

  describe '#evaluate!' do
    let(:block) { proc { this_gets_called_on_the_instance } }

    before do
      definition.stub(:this_gets_called_on_the_instance)
      definition.evaluate!(&block)
    end

    it { should have_received :this_gets_called_on_the_instance }
  end
end
