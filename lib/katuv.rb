# encoding: utf-8

require 'katuv/version'

require 'ast'
require 'delegate'

require 'katuv/dsl'

module Katuv
  def self.dsl(namespace, &block)
    raise DSL::NoDefinitionBlock unless block_given?
    DSL.define(namespace, &block)
  end
end
