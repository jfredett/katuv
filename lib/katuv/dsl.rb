# encoding: utf-8

require 'katuv/dsl/definition'
require 'katuv/dsl/nodes'
require 'katuv/dsl/node'
require 'katuv/dsl/relationships'
require 'katuv/dsl/relationship'
require 'katuv/dsl/terminal'
require 'katuv/dsl/nonterminal'
require 'katuv/dsl/root'
require 'katuv/dsl/multiple_roots_error'

module Katuv
  module DSL
    def self.define(namespace, &block)
      Definition.new(namespace).tap do |defn|
        defn.evaluate!(&block) if block_given?
      end
    end

    def self.parse!(definition)
    end
  end
end
