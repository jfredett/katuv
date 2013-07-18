module Katuv
  module NodeBehavior
    def initialize(name = nil, opts = {}, &block)
      @parent = opts[:parent]
      @name = name
      @opts = opts
      @block = block if terminal?
      run! &block
    end
    attr_reader :parent, :name

    def terminal?
      self.class.terminal?
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
