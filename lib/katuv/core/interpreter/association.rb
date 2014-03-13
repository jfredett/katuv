module Katuv
  module Core
    module Interpreter
      class AssociationInterpreter < AST::Processor
        attr_reader :name, :type, :optional
        def on_name(node)
        end

        def on_type(node)
        end

        def on_optional?(node)
        end

        private :optional
        def optional?; optional; end
      end
    end
  end
end
