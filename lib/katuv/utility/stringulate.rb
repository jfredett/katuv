module Katuv
  module Utility
    class Stringulate
      def initialize(string_or_hash)
        case string_or_hash
        when String, Symbol
          guess_type(string_or_hash.to_s)
        when Hash
          send("#{string_or_hash.keys.first}=", string_or_hash.values.first)
        end
      end

      def guess_type(string)
        case string
        when /^[a-z_0-9]*$/
          self.snake_case = string
        when /^[a-z][A-Za-z0-9]*$/
          self.camel_case = string
        when /^[A-Z][A-Za-z0-9]*$/
          self.class_case = string
        when /^[A-Z_]*$/
          self.screaming_snake_case = string
        else
          raise 'unrecognized string type'
        end
      end

      # snake_case
      attr_reader :snake_case

      # camelCase
      def camel_case
        @camel_case ||= @snake_case.gsub(/_[a-z]/) { |match| match[1].upcase }
      end

      # ClassCase
      def class_case
        @class_case ||= camel_case.gsub(/^[a-z]/) { |match| match[0].upcase }
      end

      # SCREAMING_SNAKE_CASE
      def screaming_snake_case
        @screaming_snake_case ||= @snake_case.upcase
      end

      private

      # camelCase
      def camel_case=(string)
        @camel_case = string
        scanner = StringScanner.new(string)
        @snake_case = ''
        until scanner.eos?
          if scan = scanner.scan_until(/[A-Z]/)
            @snake_case += scanner.pre_match
            @snake_case += '_'
            @snake_case += scan.chars.last.downcase
          end
          @snake_case += scanner.scan(/[a-z]+/)
        end
      end

      # SCREAMING_SNAKE_CASE
      def screaming_snake_case=(string)
        @screaming_snake_case = string.to_s
        @snake_case = string.downcase.to_s
      end

      # ClassCase
      def class_case=(string)
        @class_case = string.to_s
        self.camel_case = "#{string[0].downcase}#{string[(1..-1)]}"
      end

      # snake_case
      def snake_case=(string)
        @snake_case = string.to_s
      end
    end
  end
end
