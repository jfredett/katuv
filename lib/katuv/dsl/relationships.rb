# encoding: utf-8

module Katuv
  module DSL
    class Relationships < DelegateClass(Array)
      def initialize
        super([])
      end
    end
  end
end
