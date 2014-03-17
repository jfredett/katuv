# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Context::Factory do
  before  { module ExampleNamespace; end }
  subject { Katuv::DSL::Context::Factory.new(ExampleNamespace) }
  after   { Object.send(:remove_const, :ExampleNamespace) }

  describe 'api' do
    context 'instance' do
      it { should respond_to :create }
      it { should respond_to :find }
      it { should respond_to :namespace }
    end
  end
end
