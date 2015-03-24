module DaisybillApi
  module Ext
    module TypeCastings
      class << self
        def convert_to(value, type)
          return if value.nil? || (value.is_a?(String) && value.strip.empty?)
          case type
            when :integer
              to_integer(value)
            when :string
              to_string(value)
            when :date
              to_date(value)
            when :datetime
              to_datetime(value)
            else
              raise 'Unknown Type'
          end
        end

        private

        def to_date(value)
          Date.parse value rescue nil
        end

        def to_datetime(value)
          DateTime.iso8601 value rescue nil
        end

        def to_integer(value)
          value.to_i rescue nil
        end

        def to_string(value)
          value.to_s rescue nil
        end
      end
    end
  end
end
