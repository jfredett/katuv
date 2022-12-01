# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Node, Katuv::Core::Terminal do
  it_behaves_like 'a relatable node called', :terminal do
    let(:klass) { Katuv::Core::Terminal }
  end

  subject(:terminal) { Katuv::Core::Terminal.new(:term) }
  its(:ast) { should == s(:terminal, s(:name, :term)) }
  its(:type) { should == :terminal }
end
