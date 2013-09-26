# encoding: utf-8

require 'katuv/dsl/definition'
require 'katuv/dsl/terminal'
require 'katuv/dsl/nonterminal'
require 'katuv/dsl/root'

module Katuv
  module DSL
    def self.define(namespace, &block)
      Definition.new(namespace).tap do |defn|
        defn.evaluate!(&block) if block_given?
      end
    end
  end
end
