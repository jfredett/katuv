module Katuv
  module DSL
    module Validator
      module Factory
        def self.build(assoc)
          ret = []
          ret << RequiredAssociation.new(assoc.name) if assoc.required?
          ret << UniqueAssociation.new(assoc.name) if assoc.type == :single
          ret
        end
      end
    end
  end
end

