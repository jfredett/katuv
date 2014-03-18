# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Validator::Validation do
  subject { Katuv::DSL::Validator::Validation.new(:test_name) }

  describe 'api' do
    it { should respond_to :name   }
    it { should respond_to :result }
  end

  its(:name) { should == :test_name }
end
