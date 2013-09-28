# encoding: utf-8

module Katuv
  module DSL
    class Relationship
      def self.many(name)
        new(name, :many, false)
      end

      def self.maybe_many(name)
        new(name, :many, true)
      end

      def self.one(name)
        new(name, :single, false)
      end

      def self.maybe_one(name)
        new(name, :single, true)
      end

      def initialize(name, type, optional)
        @name = name
        @type = type
        @optional = optional
      end
      protected :initialize

      attr_reader :name, :type

      def optional?
        @optional
      end
    end
  end
end
