# encoding: utf-8

module Katuv
  module Core
    class Relationship
      def self.many(name)
        Relationship.new(name, :many)
      end

      def self.maybe_many(name)
        OptionalRelationship.new(name, :many)
      end

      def self.one(name)
        Relationship.new(name, :single)
      end

      def self.maybe_one(name)
        OptionalRelationship.new(name, :single)
      end

      def initialize(name, type)
        @name = name
        @type = type
      end
      protected :initialize

      attr_reader :name, :type

      def ast
        s(:association,
          s(:name, name),
          s(:type, type),
          s(:optional?, optional?))
      end

      def optional?
        false
      end
    end

    class OptionalRelationship < Relationship
      def optional?
        true
      end
    end
  end
end
