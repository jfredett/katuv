# encoding: utf-8

module Katuv
  module Core
    # Convert a DSLDL AST and produce something that compiles a DSL AST
    class Interpreter < AST::Processor
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
    end
  end
end
  end
end
