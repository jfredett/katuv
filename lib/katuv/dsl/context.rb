module Katuv
  module DSL
    module Context
      def included(host)
        super
        host.extend(ClassMethods)
      end

      module ClassMethods
      end
    end
  end
end
