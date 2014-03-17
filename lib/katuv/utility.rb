module Katuv
  module Utility
    # takes snake_case_string -> CapitalCamelCaseString
    def self.classify(string)
      string.gsub(/(_[a-z]|^[a-z])/) { |match| match[-1].upcase }
    end

    # takes CapitalCamelCaseString -> CapitalCamelCaseConstant
    def self.constantize(string, namespace = Object)
      # this is not a great way to implement this
      namespace.const_get(string) rescue nil
    end
  end
end
