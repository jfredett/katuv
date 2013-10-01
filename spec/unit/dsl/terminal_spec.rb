# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Terminal do
  it_behaves_like 'a relatable node called', :terminal do
    let(:klass) { Katuv::DSL::Terminal }
  end

  subject(:terminal) { Katuv::DSL::Terminal.new(:term) }
  its(:ast) { should == s(:terminal, s(:name, :term)) }
end
