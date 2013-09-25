# encoding: utf-8

require 'katuv/version'

require 'ast'

require 'katuv/dsl'

module Katuv
  def self.dsl(namespace)
    DSL::Definition.define(namespace)
  end
end
