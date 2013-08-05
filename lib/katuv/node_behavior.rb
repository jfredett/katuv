module Katuv
  module NodeBehavior
    def initialize(name = nil, opts = {}, &block)
      @parent = opts[:parent]
      @name = name
      @opts = opts
      @block = block
      run! &block unless terminal?
    end
    attr_reader :parent, :name

    def terminal?
      self.class.terminal?
    end

    def block
      # pretend there's no method if we're not a terminal class.
      raise NoMethodError unless terminal?
      @block
    end

    def arity
      @block.arity
    end

    def parameters
      @block.parameters
    end

    def each(&block)
      children.values.each(&block)
    end

    def run!(&block)
      instance_eval &block if block_given?
    end

    def children
      @children ||= {}
    end

    def has_children?
      children.any?
    end
  end
end
