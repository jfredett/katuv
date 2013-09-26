# encoding: utf-8

module Katuv
  module DSL
    class Terminal
      def initialize(name)
        @name = name
      end
      attr_reader :name

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
