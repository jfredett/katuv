# encoding: utf-8

require 'katuv/dsl/definition'
require 'katuv/dsl/nodes'
require 'katuv/dsl/node'
require 'katuv/dsl/relationships'
require 'katuv/dsl/relationship'
require 'katuv/dsl/terminal'
require 'katuv/dsl/nonterminal'
require 'katuv/dsl/root'
require 'katuv/dsl/errors'

module Katuv
  module DSL
    def self.define(namespace, &block)
      Definition.new(namespace).tap do |defn|
        defn.evaluate!(&block) if block_given?
      end
    end

    def self.parse!(definition)
      s(:dsl, *definition.ast)
    end

    def self.interpret!(compiled_definition)
    end

    def self.compile!(parsed_definition)
    end
  end
end
