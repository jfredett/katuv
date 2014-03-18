module Katuv
  module DSL
    module Validator
      # ensures there is 0 or 1 instances of an association
      class UniqueAssociation < Validation
        def validate(object)
          raise NoMethodError unless object.respond_to? :find_associations_by_name
          self.result = Result.new(
            status: object.find_associations_by_name(name).length <= 1
          )
        end
      end
    end
  end
end
