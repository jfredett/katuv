# encoding: utf-8

module Katuv
  module Core
    class Definition
      def initialize(namespace)
        @namespace = namespace
        @nodes = Nodes.new
      end
      attr_reader :namespace, :nodes

      def type
        :definition
      end

      def terminal(name, &block)
        create_node(Terminal, name, &block)
      end

      def nonterminal(name, &block)
        create_node(Nonterminal, name, &block)
      end

      def root(name, &block)
        create_node(Root, name, &block)
      end

      def evaluate!(&block)
        raise ArgumentError, 'must supply block' unless block_given?
        instance_eval &block
      end

      def ast
        [s(:namespace, namespace),
         nodes.ast]
      end

      private

      def create_node(type, name, &block)
        type.new(name).tap do |term|
          term.instance_eval &block if block_given?
          nodes << term
        end
      end
    end
  end
end
