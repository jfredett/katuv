module Katuv
  module DSL
    module Validator
      class Validation
        include Concord.new(:name)

        attr_reader :result

        private

        attr_writer :result
      end
    end
  end
end
