require 'spec_helper'
describe 'a dsl defined directly with katuv classes' do
  before :all do
    class Bar
      include Katuv::Node
      terminal!
    end

    class Baz
      include Katuv::Node

      terminal!

      def self.name
        'Quux'
      end
    end

    class Foo
      include Katuv::Node
      multiple Bar
      terminal Baz
      nonterminal Foo
    end
  end

  # A necessary bit of boilerplate required to start a script. you could,
  # in theory, just do "Foo.new" to start the script, but you'd have to
  # explicitly pass the parent.
  #
  # In needs to be in the outer scope (ie, not in the before block) so tests can
  # get at it.
  def foo(name = nil, opts={}, &block)
    Foo.new(name, opts.merge(parent: nil), &block)
  end

  after :all do
    Object.send(:remove_const, :Bar)
    Object.send(:remove_const, :Baz)
    Object.send(:remove_const, :Foo)
  end

  describe 'a correctly written script' do
    subject :example_dsl_script do
      foo do
        bar '1'
        bar '2'
        quux 'bingle'

        foo do
          bar '3'
          bar '4'

          quux 'bangle'
        end
      end
    end

    it "parses the example script cleanly, raising no errors" do
      expect { example_dsl_script }.to_not raise_error Katuv::DSL::NonterminalInTerminalError
      expect { example_dsl_script }.to_not raise_error Katuv::DSL::TerminalAlreadySetError
      expect { example_dsl_script }.to_not raise_error Katuv::DSL::InvalidNodeTypeError
    end

    context 'setting a terminal twice' do
      subject :example_dsl_script do
        foo do
          bar '1'

          quux '2'
          quux 'bingle'
        end
      end

      it 'raises a TerminalAlreadySetError' do
        expect { example_dsl_script }.to raise_error Katuv::DSL::TerminalAlreadySetError
      end
    end
  end
end

