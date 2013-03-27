require 'spec_helper'

describe 'The Katuv DSL' do
  before :all do
    class Example
    end
  end
  subject { Example }

  context 'before inclusion' do
    describe 'api' do
      it { should_not respond_to :terminal }
      it { should_not respond_to :nonterminal }
      it { should_not respond_to :multiple }
    end
  end

  context 'after inclusion' do
    before do
      class Example
        include Katuv::Node
      end
    end

    describe 'api' do
      it { should respond_to :terminal }
      it { should respond_to :nonterminal }
      it { should respond_to :multiple }
    end
  end
end
