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
          node_def = NodeInterpreter.new.process(node)
          binding.pry
        end

        def on_nonterminal(node)
          node_def = NodeInterpreter.new.process(node)
          # define context class
          #   define execution method on context class


        end

        def on_terminal(node)
          node_def = NodeInterpreter.new.process(node)

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
