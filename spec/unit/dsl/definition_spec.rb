# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Definition do
  let(:block) { proc { shibboleth } }
  subject(:definition) { Katuv::DSL::Definition.new(:SomeNamespace) }

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
    end.to raise_error Katuv::DSL::MultipleRootsError
  end

  it "raises no error when trying to define more nodes after the root node has been defined"  do
    expect do
      definition.root(:root1)
      definition.terminal(:term)
    end.to_not raise_error
  end

  it "creates an ast as expected" do
    definition.ast.should == [
      s(:namespace, :SomeNamespace),
      s(:nodes, *definition.nodes.ast)
    ]
  end

  describe '#evaluate!' do
    before do
      definition.stub(:shibboleth)
      definition.evaluate!(&block)
    end

    it { should have_received :shibboleth }

    specify { expect { definition.evaluate! }.to raise_error ArgumentError, "must supply block" }
  end

  describe '#terminal' do
    it_should_behave_like 'a node called', :terminal do
      let(:klass) { Katuv::DSL::Terminal }
    end
  end

  describe '#nonterminal' do
    it_should_behave_like 'a node called', :nonterminal do
      let(:klass) { Katuv::DSL::Nonterminal }
    end
  end

  describe '#root' do
    it_should_behave_like 'a node called', :root do
      let(:klass) { Katuv::DSL::Root }
    end
  end
end
