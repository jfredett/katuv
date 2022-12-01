# encoding: utf-8
require 'spec_helper'

RSpec.describe Katuv, 'the dsl-dsl' do
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

  let(:the_sexp_ast) do
    s(:dsl,
      s(:namespace, :ExampleDSL),
      s(:nodes,
        s(:terminal, s(:name, :Foo)),
        s(:nonterminal,
          s(:name, :Bar),
          s(:associations,
            s(:association,
              s(:name, :Foo),
              s(:type, :single),
              s(:optional?, false)))),
        s(:nonterminal,
          s(:name, :Baz),
          s(:associations,
            s(:association,
              s(:name, :Foo),
              s(:type, :single),
              s(:optional?, false)),
            s(:association,
              s(:name, :Bar),
              s(:type, :single),
              s(:optional?, true)))),
        s(:nonterminal,
          s(:name, :Bingle),
          s(:associations,
            s(:association,
              s(:name, :Foo),
              s(:type, :many),
              s(:optional?, false)))),
        s(:root,
          s(:name, :my_dsl),
          s(:associations,
            s(:association,
              s(:name, :Baz),
              s(:type, :single),
              s(:optional?, true)),
            s(:association,
              s(:name, :Bingle),
              s(:type, :single),
              s(:optional?, true))))))
  end

  specify "The example DSL code should parse into the expected parse tree" do
    Katuv::Core.parse!(the_example_dsl).should == the_sexp_ast
  end
end
