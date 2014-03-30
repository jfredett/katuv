require 'katuv/utility/stringulate.rb'

module Katuv
  module Utility
    # takes a string in snake_case, camelCase, ClassCase, or
    # SCREAMING_SNAKE_CASE and returns the ClassCase version of it
    def self.classify(string)
      Stringulate.new(string).class_case
    end

    # takes a string in snake_case, camelCase, ClassCase, or
    # SCREAMING_SNAKE_CASE and returns the class constant associated
    # with the ClassCase version of it
    def self.constantize(string, namespace = Object)
      # this is not a great way to implement this
      namespace.const_get(string) rescue nil
    end

    # takes a string in snake_case, camelCase, ClassCase, or
    # SCREAMING_SNAKE_CASE and returns the snake_case version of it
    def self.snake_casify(string)
      Stringulate.new(string).snake_case
    end
  end
end
