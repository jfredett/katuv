# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv::Core::Definition do
  let(:block) { proc { shibboleth } }
  subject(:definition) { Katuv::Core::Definition.new(:SomeNamespace) }

  describe 'api of the returned object' do
    it { should respond_to :terminal    }
    it { should respond_to :nonterminal }
    it { should respond_to :root        }
    it { should respond_to :evaluate!   }
    it { should respond_to :nodes       }
    it { should respond_to :namespace   }
    it { should respond_to :type        }
    it { should respond_to :nodes       }
    it { should respond_to :ast         }
  end

  its(:type) { should == :definition }
  its(:namespace) { should == :SomeNamespace }


  it "raises an error when trying to define the root node more than once"  do
    expect do
      definition.root(:root1)
      definition.root(:root2)
    end.to raise_error Katuv::Core::MultipleRootsError
  end

  it "raises no error when trying to define more nodes after the root node has been defined"  do
    expect do
      definition.root(:root1)
      definition.terminal(:term)
    end.to_not raise_error
  end

  describe '#nodes' do
    before do
      definition.terminal(:term1)
      definition.terminal(:term2)
      definition.root(:root)
    end

    subject { definition }

    its("nodes.length") { should == 3 }

    it 'has the nodes which were added to the definition' do
      definition.nodes.map(&:name) =~ [:term1, :term2, :root ]
    end
  end


  describe '#ast' do
    it "creates an ast as expected" do
      definition.ast.should == [
        s(:namespace, :SomeNamespace),
        s(:nodes, *definition.nodes.ast)
      ]
    end
  end

  describe '#evaluate!' do
    
    specify "calls the methods in the block" do
      definition.stub(:shibboleth)
      definition.evaluate!(&block)
      definition.should have_received :shibboleth
    end

    specify "fails without a supplied block" do
      expect { definition.evaluate! }.to raise_error ArgumentError, "must supply block"
    end

  end

  describe '#terminal' do
    it_should_behave_like 'a node called', :terminal do
      let(:klass) { Katuv::Core::Terminal }
    end
  end

  describe '#nonterminal' do
    it_should_behave_like 'a node called', :nonterminal do
      let(:klass) { Katuv::Core::Nonterminal }
    end
  end

  describe '#root' do
    it_should_behave_like 'a node called', :root do
      let(:klass) { Katuv::Core::Root }
    end
  end
end
