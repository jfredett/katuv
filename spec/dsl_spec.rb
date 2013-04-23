require 'spec_helper'

describe 'The Katuv DSL' do
  before :all do
    class Example
    end
  end
  subject(:example) { Example }

  context 'before inclusion' do
    describe 'api' do
      it { should_not respond_to :terminal }
      it { should_not respond_to :terminal! }
      it { should_not respond_to :terminal? }
      it { should_not respond_to :nonterminal }
      it { should_not respond_to :multiple }

      #technically private, but we need to test it... badly.
      it { should_not respond_to :_type_to_method_name }
    end
  end

  context 'after inclusion' do
    before :all do
      class Example
        include Katuv::Node
      end
    end

    describe 'api' do
      it { should respond_to :terminal }
      it { should respond_to :terminal! }
      it { should respond_to :terminal? }

      it { should respond_to :nonterminal }
      it { should respond_to :multiple }

      #technically private, but we need to test it... badly.
      it { should respond_to :_type_to_method_name }
    end

    context do
      describe '#_type_to_method_name' do
        # this is kind of lousy
        subject { example._type_to_method_name(example) }

        it { should == 'example' }
      end
    end
  end
end
