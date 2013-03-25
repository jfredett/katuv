require 'spec_helper'

describe Katuv::Node do
  before do
    class Example
      include Katuv::Node
    end

    class ExampleTerminal
      include Katuv::Node
      terminal!
    end
  end
  after { Object.send(:remove_const, :Example) }


  describe '#terminal!' do
    context 'a terminal node' do
      subject { ExampleTerminal }
      it { should be_terminal }
    end

    context 'making a node terminal' do
      before { Example.should_not be_terminal }

      it 'is made terminal by calling the #terminal! method' do
        class Example
          terminal!
        end
      end

      after { Example.should be_terminal }
    end


  end

  describe 'a simple, single-class example' do
    context 'class methods' do
      subject(:katuv_class) { Example }

      describe 'api' do
        it { should respond_to :nonterminal }
        it { should respond_to :terminal    }
        it { should respond_to :multiple    }
      end

      describe '#_type_to_method_name' do
        it { should == Example }
      end

      describe
    end

    context 'instance methods' do
      subject(:katuv_class) { Example.new }

      describe 'api' do
        it { should respond_to :each          }
        it { should respond_to :children      }
        it { should respond_to :has_children? }
        it { should respond_to :terminal?     }
        it { should respond_to :run           }
        it { should respond_to :visit         }
      end

      its(:method_name) { should == :example }

      it { should_not have_children }
      describe '#children' do
        subject { katuv_class.children }
        it { should be_empty }
      end
    end
  end
end
