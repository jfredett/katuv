# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core do
  describe 'api' do
    it { should respond_to :parse! }
    it { should respond_to :define }
  end

  describe '#parse!' do
    #let(:definition) { double('definition of a dsl') }

    #specify "calls out to the definition to get it's ast" do
    #  allow(definition).to receive(:ast).and_return([])
    #  Katuv::Core.parse!(definition)
    #  expect(definition).should have_received(:ast)
    #end
  end
end
