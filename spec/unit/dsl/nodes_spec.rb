# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Nodes do
  subject(:nodes) { Katuv::DSL::Nodes.new }

  describe 'api' do
    it { should respond_to :<< }
    it { should respond_to :each }
  end
end
