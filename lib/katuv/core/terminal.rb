# encoding: utf-8

module Katuv
  module Core
    class Terminal
      include Node

      def type
        :terminal
      end

      def ast
        s(type, s(:name, name))
      end
    end
  end
end
