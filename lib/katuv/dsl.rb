# encoding: utf-8

require 'katuv/dsl/definition'

module Katuv
  module DSL
    def self.define(namespace)
      Definition.new(namespace)
    end
  end
end
