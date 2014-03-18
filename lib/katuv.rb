# encoding: utf-8

require 'katuv/version'

require 'ast'
require 'delegate'
require 'concord'
require 'anima'

require 'katuv/utility'
require 'katuv/core'

module Katuv
  def self.dsl(namespace, &block)
    raise Core::NoDefinitionBlock unless block_given?
    Core.define(namespace, &block)
  end
end
