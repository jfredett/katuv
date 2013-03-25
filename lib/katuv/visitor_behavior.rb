module Katuv
  module VisitorBehavior
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
    def has_children?
      children.any?
    end
  end
end
