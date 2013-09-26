# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Terminal do
  describe 'api' do
    it { should respond_to :many       }
    it { should respond_to :one        }
    it { should respond_to :maybe_many }
    it { should respond_to :maybe_one  }
    it { should respond_to :name       }
  end

  subject(:terminal) { Katuv::DSL::Terminal.new(:SomeName) }

  specify "requires the argument" do
    expect { Katuv::DSL::Terminal.new }.to raise_error ArgumentError, "method 'initialize': given 0, expected 1"
  end

  its(:name) { should == :SomeName }
end
