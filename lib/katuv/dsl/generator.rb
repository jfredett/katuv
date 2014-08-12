module Katuv
  class DSL
    # take parsetree -> generate namespace w/ generated dsl parser
    class Generator
      include Anima.new(:ast)

      def generate!
        names = NameFinder.new.process(ast)
        methods = MethodBuilder.new.process(ast)

        root_namespace = Module.new(names.namespace.to_sym)

        klasses = {}
        names.klasses.each do |klassname|
          klasses[klassname] = Class.new
          root_namespace.set_const(klassname, klasses[klassname])
        end

        # a hash from classname -> method_spec
        # method_spec = [name, type, options_hash]
        methods.by_class.each do |klass_method_group|
          klassname = klass_method_group.keys.first
          klass_method_group.values.each do |name, type, opts|
            klasses[klassname].define_method(name, implementations[type])
          end
        end
      end
    end

    # TODO: Move Stringulate into 'master'

    # transformer structure takes ast and creates:
    #
    # { namespace: SomeConstantAsSymbol>,
    #   klasses: [List, Of, Symbols, As, Constants]
    #   methods: {
    #     ClassName: [
    #       [method_name, method_type, extra_options],
    #       [method_name, method_type, extra_options],
    #       ...
    #     ],
    #     ...
    #   }
    # }
    #
    # method types:
    #
    # May be able to implement these in terms of the `required` option below
    #
    # single optional #=> 0 or 1      -- equiv to: { min: 0, max: 1 }
    # single required #=> exactly 1   -- equiv to: { min: 1, max: 1 } or { requires : 1 }
    # many optional   #=> 0+          -- equiv to: { min: 0 }
    # many required   #=> 1+          -- equiv to: { min: 1 }
    #
    # possible additional options
    #
    # bounds checking, i.e.,
    #   { min: 5 }      #=> must specify *at least* 5 copies
    #   { max: 5 }      #=> may specify *at most* 5 copies
    #   { requires: 5 } #=> must specify precisely 5 copies
    #       ^-- shorthand for { min: 5, max: 5 }
    #
    # basic format/type checkin
    #   { type: Integer }             #=> provided value must be an integer
    #   { matches: /regex/ }          #=> given string must match given regex
    #   { responds_to: :some_method } #=> given object must respond to given method name
    #
    #

    class NameFinder < AST::Transformer
      alias on_dsl process_all
      alias on_nodes process_all

      def on_namespace(node)
        # set namespace
      end

      def on_terminal(node)
        # add class to list
      end

      def on_nonterminal(node)
        # add class to list
      end

      def on_root(node)
        # add class to list
      end
    end

    class MethodFinder < AST::Transformer
      alias on_dsl process_all
      alias on_nodes process_all

      def on_namespace(node)
        # set namespace
      end

      def on_terminal(node)
        # add class to list
      end

      def on_nonterminal(node)
        # add class to list
      end

      def on_root(node)
        # add class to list
      end

    end

    # take parsetree + empty namespace -> namespace w/ class definitions + map
    # of nodename -> class-in-namespace-associated-with-that-name
    class SkeletonBuilder
    end

    # take parsetree + skeletonized namespace + some class in that namespace -> namespace w/
    # association-building methods attached for the given class
    class MethodBuilder
      def self.for(klass)
        new(klass)
      end
    end
  end
end
