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
      it { should respond_to :ast }
    end

    its("nodes.length") { should == 1 }
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
    # FIXME: I don't like these, I don't really know what they're testing
    #it 'calls the block on the created terminal instance' do
    #  expect(klass).to receive(:shibboleth)
    #  definition.send(name, :SomeName, &block)
    #end

    #it 'just returns the instance if no block is given' do
    #  expect(klass).to_not receive(:shibboleth)
    #  definition.send(name, :SomeName)
    #end
  end
end
