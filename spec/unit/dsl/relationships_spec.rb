# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Relationships do
  subject(:relationships) { Katuv::DSL::Relationships.new }

  describe 'api' do
    it { should respond_to :<< }
    it { should respond_to :each }
  end
end
