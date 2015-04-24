module RestClient
  module Payload
    class Base
      def flatten_params_array(value, calculated_key)
        result = []
        key = "#{calculated_key}[]"
        value.each do |elem|
          if elem.is_a? Hash
            result += flatten_params(elem, key)
          elsif elem.is_a? Array
            result += flatten_params_array(elem, key)
          else
            result << [key, elem]
          end
        end
        result
      end
    end
  end
end
