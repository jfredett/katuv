require 'spec_helper'

describe Katuv do

  # returns a list of class definitions, represented as a hash/maybe a AST, a
  # la:
  #
  #
  #
=begin
-- original AST

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

-->

Initial Transform from DSL-DSL to AST

(dsl
  (namespace ExampleDSL)
  (classes
    (class
      (name Foo)
      (type Terminal))
    (class
      (name Baz)
      (type Nonterminal)
      (methods
        (method
          (name foo)
          (creates Foo)
          (type single)
          (optional? false))
        (method
          (name bar)
          (class Bar)
          (type single)
          (optional? true))))
    (class
      (name Bingle)
      (type Nonterminal)
      (methods
        (method
          (name foo)
          (creates Foo)
          (type many)
          (optional? false)))))
  (root
    (name :my_dsl)
    (type Root)
    (methods
      (method
        (name baz)
        (creates Baz)
        (type single)
        (optional? true))
      (method
        (name bingle)
        (creates Bingle)
        (type single)
        (optional? true)))))

-->

Transform from AST to code which defines all the necessary classes

module ExampleDSL
  def self.my_dsl(name, opts={}, &block)
    Root.new(name, opts, &block)
  end

  class ::Katuv::Node < AST::Node
    def self.define_dsl_method(name, klass)
      
      define_method(name) do |name, opts={}, &block|
        append klass.new(name, opts, &block)
      end
    end

    def self.defined_dsl_method?(name)
      instance_variable_get("#{name}_defined")
    end
  end

  class Node < ::Katuv::Node
  end

  class Root < Node
    def initialize(name, opts, &block)
      assign_properties opts.merge(name: name)
      instance_eval &block
    end

    def baz(name, opts={}, &block)
      append Baz.new(*args, opts={}, &block)
      self
    end

    def bingle(*args, opts={}, &block)
      Bingle.new(*args, opts={}, &block)
      self
    end
  end

  class ParseChecker < AST::Processor
    def on_baz
      if already_called?(:baz)
        raise ParseError
      end
    end

    #etc
  end

  # #type should probably be the name of the DSL method
  # #caliber = {single, many}
  # #optional? = [Boolean]
  # #block = block provided do the definition.
  #

  #etc

  # also define a processor which check required-ness / number restrictions. 
  # two pass parsing.
end

=end
end
