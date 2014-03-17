module Katuv
  module Core
    module Interpreter
      class DSL < AST::Processor
        def on_dsl(node)
          namespace, definition = *node

          process namespace
          process definition
        end

        def on_namespace(node)
          @namespace = Object.const_set(node.children.first, Module.new)
        end

        def on_nodes(nodes)
          process_all(*nodes)
        end

        def on_root(node)
        end

        def on_nonterminal(node)
        end

        def on_terminal(node)
        end

        def define_node(node)
          node_def = Node.new.process(node)
          # create a new context class in the namespace
          # define methods in the new context class for the associations
          # add validations to the context class
        end

        private

        attr_reader :namespace

        def define_dsl_method(name, &block)
          namespace.define_method(name, &block)
        end
      end
    end
  end
end
