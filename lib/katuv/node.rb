# Represents a single node in the AST of a project structure
module Katuv
  module Node
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:extend, ClassMethods)
      base.send(:include, Enumerable)
    end

    module InstanceMethods
      #this is terrible
      def method_name
        #get the classname
        self.class.name.
          #remove the module
          to_s.split('::').last.
          #convert FooBar -> _Foo_Bar
          gsub(/[A-Z]/, '_\&').
          #drop the leading _
          gsub(/^_/, '').
          #downcase everything to get foo_bar
          downcase.to_sym
      end

      def visit(visitor)
        visitor.before_visit!(self)
        visitor.call(self)

        each do |c|
          c.visit(visitor)
        end

        visitor.after_visit!(self)
        nil
      end

      def run
      end

      def each(&block)
        children.values.each(&block)
      end

      def children
        @children ||= {}
      end

      def name
        @name || self.class.name
      end

      def initialize(name = nil, opts = {}, &block)
        @parent = opts[:parent]
        @name = name
        @opts = opts
        instance_eval &block if block_given?
      end
      attr_reader :parent, :name

      def terminal?
        self.class.terminal?
      end

      def has_children?
        children.any?
      end
    end

    module ClassMethods
      def nonterminal(type)
        raise "NonterminalInTerminalError" if terminal?
        define_method(_type_to_method_name(type)) do |name=nil, opts={}, &block|
        if children.has_key?(type) and children[type]
          children[type].run(&block)
        else
          children[type] = type.new(name, opts.merge({parent: self}), &block)
        end
        children[type]
        end
      end

      def terminal(type)
        #should only allow one.
        raise "InvalidNodeTypeError" unless type.terminal?
        define_method(_type_to_method_name(type)) do |name=nil, opts={}, &block|
        raise "TerminalAlreadySetError" if children.has_key?(type)
        children[type] = type.new(name, opts.merge({parent: self}), &block)
        end
      end
      def terminal!
        define_singleton_method(:terminal?) { true }
      end
      def terminal?; false end

      def multiple(type)
        #should store an entry in #children that is a list of all the instances
        #it sees of this type. eg, `file 'x'; file 'y' #=> children[File] = [File<@name=x>, File<@name=y>]
        raise "InvalidNodeTypeError" unless type.terminal?
        define_method(_type_to_method_name(type)) do |name, opts={}, &block|
        children[type] ||= ObjectSet.new
        children[type] << type.new(name, opts.merge({parent: self}), &block)
        end
      end

      def _type_to_method_name(type)
        if type.respond_to?(:name)
          type.name
        else
          type.to_s
        end.split('::').last.downcase
      end
    end
  end
end
