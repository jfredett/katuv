# encoding: utf-8

module Katuv
  module Core
    module Node
      def initialize(name)
        @name = name
        @relationships = Relationships.new
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

      def ast
        s(type,
          s(:name, name),
          relationships.ast)
      end
    end
  end
end
