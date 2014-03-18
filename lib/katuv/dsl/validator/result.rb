module Katuv
  module DSL
    module Validator
      class Result
        include Anima.new(:status)

        private :status

        def success?
          status
        end

        def failure?
          !status
        end
      end
    end
  end
end
