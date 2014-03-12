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
        maybe_many :Baz
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

      baz "baz3" do
        foo 'foo3' do
          some_block
        end
      end

      baz "baz4" do
        foo 'foo4', key: :value
      end

      baz "baz5" do
        foo 'foo5', key: :value do
          some_other_block
        end
      end

      bingle do #names aren't required
        foo 'foo6'
      end
    end
  end


  # see notes/AST_DESIGN.mkd for details on the format.
  let(:expected_ast) do
    s(:my_dsl,
      s(:meta, { name: 'Some Script', type: :root, optional?: false, data: {} }),
      s(:children,
        s(:baz,
          s(:meta, { name: 'baz1', type: :nonterminal, optional?: false, data: {} }),
          s(:type, :nonterminal),
          s(:children,
            s(:foo,
              s(:meta, { name: 'foo1', type: :terminal, optional?: false, data: {} })))),
        s(:baz,
          s(:meta, { name: 'baz2', type: :nonterminal, optional?: false, data: {} }),
          s(:children,
            s(:foo,
              s(:meta, { name: 'foo2', type: :terminal, optional?: false, data: {} })),
            s(:bar,
              s(:meta, { name: 'bar1', type: :terminal, optional?: true, data: {} })))),
        s(:baz,
          s(:meta, {name: 'baz3', type: :nonterminal, optional?: false, data: {}}),
          s(:children,
            s(:foo,
              s(:meta, { name: 'foo3', type: :terminal, optional?: false, data: { block: double('some block') }})))),
         s(:baz,
          s(:meta, { name: 'baz4', type: :nonterminal, optional?: false, data: {}}),
          s(:children,
            s(:foo,
              s(:meta, { name: 'foo4', type: :terminal, optional?: false, data: { key: :value }})))),
         s(:baz,
          s(:meta, { name: 'baz5', type: :nonterminal, optional?: false, data: {}}),
          s(:children,
            s(:foo,
              s(:meta, { name: 'foo5', type: :terminal, optional?: false, data: { key: :value, block: double('some other block') }})))),
         s(:bingle,
           s(:meta, { name: nil, type: :nonterminal, optional?: true, data: {} }),
           s(:children,
             s(:foo, { name: 'foo6', type: :terminal, optional?: false, data: {} })))))
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
