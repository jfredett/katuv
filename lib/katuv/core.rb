# encoding: utf-8

require 'katuv/core/definition'
require 'katuv/core/nodes'
require 'katuv/core/node'
require 'katuv/core/relationships'
require 'katuv/core/relationship'
require 'katuv/core/terminal'
require 'katuv/core/nonterminal'
require 'katuv/core/root'
require 'katuv/core/errors'
require 'katuv/core/interpreter'

module Katuv
  module Core
    def self.define(namespace, &block)
      Definition.new(namespace).tap do |defn|
        defn.evaluate!(&block) if block_given?
      end
    end

    def self.parse!(definition)
      s(:dsl, *definition.ast)
    end

    def self.interpret!(parsed_definition)
      Interpreter::DSL.new.process(parsed_definition)
    end

    def self.compile!(parsed_definition)
    end
  end
end
