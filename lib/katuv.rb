# encoding: utf-8

require 'katuv/version'

require 'ast'
require 'delegate'

require 'katuv/dsl'

module Katuv
  def self.dsl(namespace)
    DSL.define(namespace)
  end
end
