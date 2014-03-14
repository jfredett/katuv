module Katuv
  module Core
    module Interpreter
      class Node < AST::Processor
        attr_reader :type, :name, :associations

        def initialize
          super
          @associations = []
        end

        def on_root(node)
          @type = :root
          dispatch_node(node)
        end

        def on_terminal(node)
          @type = :terminal
          process node.children.first #to get just the name element
        end

        def on_nonterminal(node)
          @type = :nonterminal
          dispatch_node(node)
        end

        def on_associations(node)
          @associations << Association.new.process(node)
        end

        def on_name(node)
          @name = node.children.first
        end


        private
        def dispatch_node(node)
          name, associations = *node

          process name
          process associations
        end
      end
    end
  end
end
