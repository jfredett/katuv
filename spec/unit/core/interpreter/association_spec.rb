# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter::Association do
  subject(:interpreter) { Katuv::Core::Interpreter::Association.new }


  describe '#on_name' do
    let(:sexp) { s(:name, :foo) }

    before { interpreter.on_name(sexp) }

    its(:name) { should == :foo }
  end

  describe '#on_type' do
    let(:sexp) { s(:type, :foo) }

    before { interpreter.on_type(sexp) }

    its(:type) { should == :foo }
  end

  describe '#on_optional?' do
    let(:sexp) { s(:optional?, true) }

    before { interpreter.on_optional?(sexp) }

    it { should be_optional }
    it { should_not be_required }
  end
end
