module Katuv
  module NodeBehavior
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
  end
end
