module DaisybillApi
  module Ext
    module Attributes
      class Attribute
        attr_accessor :name, :type, :options
        attr_reader :value

        def initialize(name, type, options = {})
          @name = name.to_s
          @type = type
          @options = options
          @value = [] if collection?
        end

        def value=(value)
          @value = TypeCastings.convert_to(value, type)
        end

        def readonly?
          !!options[:readonly]
        end

        def param_name
          if collection?
            simple_collection? ? name : "#{name}_attributes"
          else
            simple_type? ? name : "#{name}_attributes"
          end
        end

        def param_value
          if collection?
            simple_collection? ? value : value.map(&:to_params)
          else
            simple_type? ? value : (value && value.to_params)
          end
        end

        def to_param
          readonly? ? {} : { param_name => param_value }
        end

        private

        def simple_type?
          type.is_a? Symbol
        end

        def collection?
          type.is_a? Array
        end

        def simple_collection?
          collection? && type.first.is_a?(Symbol)
        end
      end
    end
  end
end
