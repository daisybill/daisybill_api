require 'open-uri'

module DaisybillApi
  module Ext
    module Attributes
      module TypeCastings
        class << self
          def convert_to(value, type)
            return to_array(value, type.first) if type.is_a? Array
            return if value.nil? || (value.is_a?(String) && value.strip.empty?)
            return to_class(value, type) if type.is_a? Class
            case type
              when :integer
                to_integer(value)
              when :string
                to_string(value)
              when :date
                to_date(value)
              when :datetime
                to_datetime(value)
              when :boolean
                to_boolean(value)
              when :attachment
                to_attachment(value)
              else
                raise 'Unknown Type'
            end
          end

          private

          def to_date(value)
            return value.to_date if value.respond_to? :to_date
            Date.parse value rescue nil
          end

          def to_datetime(value)
            return value.to_datetime if value.respond_to? :to_datetime
            DateTime.iso8601 value rescue nil
          end

          def to_integer(value)
            value.to_i rescue nil
          end

          def to_string(value)
            value.to_s rescue nil
          end

          def to_boolean(value)
            !!value
          end

          def to_class(attributes, type)
            return attributes if attributes.is_a? type
            type.new attributes rescue nil
          end

          def to_array(values, type)
            return [] if values.nil?
            values.map { |value| convert_to value, type }
          end

          def to_attachment(value)
            return open(value) if value.is_a? String
            value if value.is_a?(StringIO) || value.kind_of?(IO)
          end
        end
      end
    end
  end
end
