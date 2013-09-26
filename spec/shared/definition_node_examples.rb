shared_examples_for 'a definition node called' do |name|
  let(:block) { proc { shibboleth } }
  let(:klass) { raise "You need to set klass in the shared block" }

  subject { definition.send(name, :namespace) }

  specify { expect { definition.send(name) }.to raise_error ArgumentError, "method '#{name}': given 0, expected 1" }
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