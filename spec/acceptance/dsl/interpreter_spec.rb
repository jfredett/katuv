# encoding: utf-8

require 'spec_helper'

describe Katuv do
  subject(:the_example_dsl) do
    Katuv.dsl :ExampleDSL do
      terminal :Foo

      nonterminal :Bar do
        one :Foo
      end

      nonterminal :Baz do
        one :Foo
        maybe_one :Bar
      end

      nonterminal :Bingle do
        many :Foo
      end

      root :my_dsl do
        maybe_one :Baz
        maybe_one :Bingle
      end
    end
  end

  let(:example_dsl_script) do
    ExampleDSL.my_dsl "Some Script" do
      baz "baz1" do
        foo 'foo1' # foo is required by baz
      end

      baz "baz2" do
        foo 'foo2'
        bar 'bar1' # foo is not required in a bar, so the block isn't either
      end

      bingle do #names aren't required
        foo 'foo3'
      end
    end
  end

  let(:expected_ast) do
    #TODO: How should the AST be structured?
  end

  before do
    Katuv::DSL.compile!(Katuv::DSL.parse!(the_example_dsl))
  end

  specify "the example dsl script should parse" do
    expect { example_dsl_script }.to_not raise_error
  end

  specify "the example dsl script should produce an AST" do

  end
end
