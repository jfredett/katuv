module Katuv
  module Node
    def self.included(base)
      base.send(:include, VisitorBehavior)

      base.send(:include, NamingBehavior)
      base.send(:include, NodeBehavior)

      base.send(:extend, DSL)
    end

    def inspect
      method_name
    end
  end
end
