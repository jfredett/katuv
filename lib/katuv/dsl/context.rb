module Katuv
  module DSL
    module Context
      def self.included(host)
        host.extend(ClassMethods)
      end

      def valid?
        validations.all?(&:success?) and children.all?(&:valid?)
      end

      def validations
        self.class.validations
      end

      module ClassMethods
        def add_validations(validations)
          @validations ||= []
          @validations += Array(validations)
          nil
        end

        attr_reader :validations
      end
    end
  end
end
