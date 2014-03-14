# encoding: utf-8
require 'spec_helper'

describe Katuv::Core::Interpreter::Node do
  subject(:interpreter) { Katuv::Core::Interpreter::Node.new }
  let(:fake_associations) { double('associations') }
  let(:fake_name) { double('associations') }

  describe '#on_root' do
    let(:sexp) do
      s(:root,
        fake_name,
        fake_associations)
    end

    before do
      interpreter.stub(:process).with(fake_name)
      interpreter.stub(:process).with(fake_associations)
      interpreter.on_root(sexp)
    end

    it { should have_received(:process).with(fake_name) }
    it { should have_received(:process).with(fake_associations) }
  end

  describe '#on_nonterminal' do
    let(:sexp) do
      s(:nonterminal,
        fake_name,
        fake_associations)
    end

    before do
      interpreter.stub(:process).with(fake_name)
      interpreter.stub(:process).with(fake_associations)
      interpreter.on_nonterminal(sexp)
    end

    it { should have_received(:process).with(fake_name) }
    it { should have_received(:process).with(fake_associations) }
  end

  describe '#on_terminal' do
    let(:sexp) do
      s(:terminal,
        fake_name)
    end

    before do
      interpreter.stub(:process).with(fake_name)
      interpreter.on_terminal(sexp)
    end

    it { should have_received(:process).with(fake_name) }
  end

  describe '#on_association' do
    let(:sexp) { s(:association, double('sexp')) }

    it "invokes the Association processor" do
      Katuv::Core::Interpreter::Association
        .any_instance.should_receive(:process).with(sexp)
      interpreter.on_association(sexp)
    end
  end

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
end
