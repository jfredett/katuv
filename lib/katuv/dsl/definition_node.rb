# encoding: utf-8

module Katuv
  module DSL
    module DefinitionNode
      def initialize(name)
        @name = name
        @relationships = []
      end
      attr_reader :name, :relationships

      def many
      end

      def one
      end

      def maybe_many
      end

      def maybe_one
      end
    end
  end
end
