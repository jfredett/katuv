# encoding: utf-8

module Katuv
  module DSL
    class Definition
      def initialize(namespace)
        @namespace = namespace
      end
      attr_reader :namespace

      def terminal

      end

      def nonterminal

      end

      def root

      end

      def evaluate!(&block)
        instance_eval &block
      end
    end
  end
end
