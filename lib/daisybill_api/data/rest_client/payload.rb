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

    class UrlEncoded
      def build_stream(params = nil)
        @stream = StringIO.new(flatten_params(params).collect do |entry|
            entry[1].nil? ? entry[0] : "#{entry[0]}=#{handle_key(entry[1])}"
          end.join("&"))
        @stream.seek(0)
      end
    end
  end
end
