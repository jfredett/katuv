# encoding: utf-8

shared_examples_for 'a relatable node called' do |name|
  let(:klass) { raise "You must do `let(:klass)` in the 'a relatable node' shared examples" }

  specify "requires the argument" do
    expect { klass.new }.to raise_error ArgumentError
  end

  describe 'api' do
    it { should respond_to :many          }
    it { should respond_to :one           }
    it { should respond_to :maybe_many    }
    it { should respond_to :maybe_one     }
    it { should respond_to :name          }
    it { should respond_to :relationships }
  end

  subject(:relatable_node) { klass.new(:SomeName) }

  specify "generates the AST as expected" do
    relatable_node.ast.should == \
      s(relatable_node.type,
        s(:name, :SomeName),
        relatable_node.relationships.ast)
  end
  its(:name) { should == :SomeName }

  describe '#many' do
    before { relatable_node.many :RelationshipName }

    subject { relatable_node.relationships.first }

    its(:type) { should == :many }
    its(:name) { should == :RelationshipName }
    it { should_not be_optional }
  end

  describe '#maybe_many' do
    before { relatable_node.maybe_many :RelationshipName }

    subject { relatable_node.relationships.first }

    its(:type) { should == :many }
    its(:name) { should == :RelationshipName }
    it { should be_optional }
  end

  describe '#one' do
    before { relatable_node.one :RelationshipName }

    subject { relatable_node.relationships.first }

    its(:type) { should == :single }
    its(:name) { should == :RelationshipName }
    it { should_not be_optional }
  end

  describe '#maybe_one' do
    before { relatable_node.maybe_one :RelationshipName }

    subject { relatable_node.relationships.first }

    its(:type) { should == :single }
    its(:name) { should == :RelationshipName }
    it { should be_optional }
  end
end
