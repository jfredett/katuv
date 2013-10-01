# encoding: utf-8

module Katuv
  module DSL
    class Terminal
      include Node

      def type
        :terminal
      end
    end
  end
end
