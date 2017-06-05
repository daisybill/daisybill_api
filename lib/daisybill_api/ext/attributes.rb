require "daisybill_api/ext/attributes/type_castings"
require "daisybill_api/ext/attributes/attribute"

module DaisybillApi
  module Ext
    # @private
    module Attributes
      module ClassMethods
        def attribute(name, type, options = {})
          attrs[name.to_s] = Attribute.new(name, type, options)
          class_eval do
            define_method(name) { read_attribute name }
            define_method(:"#{name}=") { |value| write_attribute name, value }
          end
        end

        def attributes(attrs)
          options = extract_options(attrs)
          attrs.each { |name, type| attribute(name, type, options) }
          attribute :created_at, :datetime, readonly: true
          attribute :updated_at, :datetime, readonly: true
        end

        def attrs
          @attrs ||= {}
        end

        def inspect
          "<#{name} #{attrs.map{ |k, v| "#{k}: #{v.type}"}.join(', ')}>"
        end

        private

        OPTION_KEYS = [:readonly]

        def extract_options(attributes)
          OPTION_KEYS.each_with_object({}) { |key, result|
            result[key] = attributes.delete key
          }
        end
      end

      module InstanceMethods
        def initialize(attributes = {})
          class_attrs.each { |a| attrs[a.name.to_sym] = a.clone }
          self.attributes = attributes
        end

        def attributes
          class_attrs.each_with_object({}) { |attr, result|
            result[attr.name] = read_attribute(attr.name)
          }
        end

        def attributes=(attributes)
          attributes.each { |name, value|
            if attrs[name.to_sym]
              write_attribute name, value
            else
              message = "Was trying to set non-existent attribute #{name.inspect} to #{value.inspect}"
              DaisybillApi.logger.debug message
            end
          }
        end

        def to_params
          attrs.values.each_with_object({}) { |attr, result|
            result.merge! attr.to_param
          }
        end

        def inspect
          "<#{self.class.name} #{attributes.map { |k, v| "#{k}: #{v.inspect}" }.join(', ')}>"
        end

        private

        def read_attribute(name)
          attrs[name.to_sym].value
        end

        def write_attribute(name, value)
          attrs[name.to_sym].value = value
        end

        def class_attrs
          @class_attrs ||= self.class.attrs.values
        end

        def attrs
          @attrs ||= {}
        end
      end

      def self.included(base)
        base.class_eval do
          include DaisybillApi::Ext::Attributes::InstanceMethods
          extend DaisybillApi::Ext::Attributes::ClassMethods
        end
      end
    end
  end
end
