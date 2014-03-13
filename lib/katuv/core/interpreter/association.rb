module Katuv
  module Core
    module Interpreter
      class Association < AST::Processor
        attr_reader :name, :type, :optional

        alias on_association process_all

        def on_name(node)
          @name = node.children.first
        end

        def on_type(node)
          @type = node.children.first
        end

        def on_optional?(node)
          @optional = node.children.first
        end

        private :optional
        def optional?; optional; end
        def required?; !optional; end
      end
    end
  end
end
