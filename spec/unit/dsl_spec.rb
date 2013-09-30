# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL do
  describe 'api' do
    it { should respond_to :parse!     }
    it { should respond_to :define     }
  end
end
