# encoding: utf-8

module Katuv
  module DSL
    class Definition
      def initialize(namespace)
        @namespace = namespace
      end
      attr_reader :namespace

      def terminal(name, &block)
        Terminal.new(name).tap do |term|
          term.instance_eval &block if block_given?
        end
      end

      def nonterminal(name, &block)
        Nonterminal.new(name).tap do |term|
          term.instance_eval &block if block_given?
        end
      end

      def root(name, &block)
        Root.new(name).tap do |term|
          term.instance_eval &block if block_given?
        end
      end

      def evaluate!(&block)
        raise ArgumentError, 'must supply block' unless block_given?
        instance_eval &block
      end
    end
  end
end
