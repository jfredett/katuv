module Katuv
  class ObjectSet < Array
    def visit(visitor)
      each do |c|
        c.visit(visitor)
      end
    end
  end
end
