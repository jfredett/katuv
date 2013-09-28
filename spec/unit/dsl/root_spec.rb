# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Root do
  it_behaves_like 'a relatable node called', :root do
    let(:klass) { Katuv::DSL::Root }
  end
end
