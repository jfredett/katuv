# encoding: utf-8

module Katuv
  module Core
    class Nodes < DelegateClass(Array)
      def initialize
        super([])
      end

      def <<(obj)
        if obj.is_a? Root
          raise MultipleRootsError if already_added_root?
          added_root!
        end

        super
      end

      def ast
        s(:nodes, *map(&:ast))
      end

      private

      attr_reader :already_added_root

      def added_root!
        @already_added_root = true
      end

      def already_added_root?
        already_added_root
      end
    end
  end
end
