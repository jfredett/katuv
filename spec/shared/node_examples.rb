# encoding: utf-8

shared_examples_for 'a node called' do |name|
  let(:block) { proc { shibboleth } }
  let(:klass) { raise "You need to set klass in the shared block" }
  let(:node) { definition.send(name, :namespace) }

  describe 'the definition' do
    subject { definition }

    before { node } # force the node into existence

    describe 'api' do
      it { should respond_to :type }
    end

    it { should have(1).nodes }
    describe 'the node' do
      subject { definition.nodes.first }
      it { should == node }
      its(:name) { should == :namespace }
    end
  end

  describe 'the node' do
    subject { node }

    specify "requires a block" do
      expect { definition.send(name) }.to raise_error ArgumentError
    end

    describe 'expected api' do
      it { should respond_to :many }
      it { should respond_to :one }
      it { should respond_to :maybe_one }
      it { should respond_to :maybe_many }
    end

    # these are integration-y
    it 'calls the block on the created terminal instance' do
      klass.any_instance.should_receive(:shibboleth)
      definition.send(name, :SomeName, &block)
    end

    it 'just returns the instance if no block is given' do
      klass.any_instance.should_not_receive(:shibboleth)
      definition.send(name, :SomeName)
    end
  end
end
