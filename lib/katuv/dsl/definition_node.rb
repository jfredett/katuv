# encoding: utf-8

module Katuv
  module DSL
    module DefinitionNode
      def initialize(name)
        @name = name
        @relationships = []
      end
      attr_reader :name, :relationships

      def many(name)
        relationships << Relationship.many(name)
      end

      def maybe_many(name)
        relationships << Relationship.maybe_many(name)
      end

      def one(name)
        relationships << Relationship.one(name)
      end

      def maybe_one(name)
        relationships << Relationship.maybe_one(name)
      end
    end
  end
end
