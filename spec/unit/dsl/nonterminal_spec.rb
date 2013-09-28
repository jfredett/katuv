# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Nonterminal do
  it_behaves_like 'a relatable node called', :nonterminal do
    let(:klass) { Katuv::DSL::Nonterminal }
  end
end
