module Katuv
  module DSL
    module Context
      class Factory
        attr_reader :namespace

        def initialize(namespace)
          @namespace = namespace
          @instances = Hash.new { {} }
        end

        def create(name, &block)
          klass = Class.new(&block)
          namespace.const_set(constantize(:name), klass)
        end

        def find
          raise 'nyi'
        end

        private

        attr_reader :instances
      end
    end
  end
end
