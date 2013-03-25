require 'spec_helper'

describe Katuv::Node do
  before do
    class Example
      include Katuv::Node
    end
  end
  after { Object.send(:remove_const, :Example) }

  context 'class methods' do
    subject(:katuv_class) { Example }

    describe 'api' do
      it { should respond_to :nonterminal }
      it { should respond_to :terminal    }
      it { should respond_to :multiple    }
    end
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
