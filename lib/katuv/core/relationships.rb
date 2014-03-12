# encoding: utf-8

module Katuv
  module Core
    class Relationships < DelegateClass(Array)
      def initialize
        super([])
      end

      def ast
        s(:associations, *map(&:ast))
      end
    end
  end
end
