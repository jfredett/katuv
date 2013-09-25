# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Definition do
  describe '#define' do
    subject { Katuv::DSL::Definition.new(:SomeNamespace) }

    describe 'api of the returned object' do
      it { should respond_to :terminal }
      it { should respond_to :nonterminal }
      it { should respond_to :root }
    end
  end
end
