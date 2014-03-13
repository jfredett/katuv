# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter do
  subject(:interpreter) { Katuv::Core::Interpreter.new }

  describe '#on_dsl' do
    let(:namespace) { double('namespace element') }
    let(:definition_subtree) { double('definition subtree') }
    let(:sexp) { s(:dsl, namespace, definition_subtree ) }

    before do
      interpreter.stub(:process).with(namespace)
      interpreter.stub(:process).with(definition_subtree)
      interpreter.on_dsl(sexp)
    end

    it { should have_received(:process).with(namespace) }
    it { should have_received(:process).with(definition_subtree) }
  end
end
