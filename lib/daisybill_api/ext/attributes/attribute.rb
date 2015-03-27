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
        end

        def value=(value)
          @value = TypeCastings.convert_to(value, type)
        end

        def readonly?
          !!options[:readonly]
        end

        def param_name
          simple_type? ? name : "#{name}_attributes"
        end

        def param_value
          simple_type? ? value : (value && value.to_params)
        end

        def to_param
          readonly? ? {} : { param_name => param_value }
        end

        private

        def simple_type?
          type.is_a? Symbol
        end
      end
    end
  end
end
