# encoding: utf-8

module Katuv
  module DSL
    class Nodes < DelegateClass(Array)
      def initialize
        super([])
      end
    end
  end
end
