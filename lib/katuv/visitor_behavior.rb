module Katuv
  module VisitorBehavior
    def self.included(base)
      base.send(:include, Enumerable)
    end

    def visit(visitor)
      visitor.before(self) if visitor.respond_to? :before

      if visitor.respond_to? method_name
        visitor.send(method_name.to_sym, self)
      else
        visitor.unknown(self)
      end

      each do |c|
        c.visit(visitor)
      end

      visitor.after(self) if visitor.respond_to? :after
      nil
    end
  end
end
