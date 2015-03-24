require 'daisybill_api/ext/type_castings'

module DaisybillApi
  module Ext
    module Attributes
      module ClassMethods
        def attribute(name, type) #TODO: add possibility to define attribute like class (e.g. Address)
          attrs[name.to_s] = type
          class_eval do
            define_method(name) { read_attribute name }
            define_method(:"#{name}=") { |value|
              casted = DaisybillApi::Ext::TypeCastings.convert_to value, type
              write_attribute name, casted
            }
          end
        end

        def attributes(attrs)
          all = attrs.merge created_at: :datetime, updated_at: :datetime
          all.each { |name, type| attribute(name, type) }
        end

        def attribute_names
          @attrs.keys
        end

        def attrs
          @attrs ||= {}
        end

        def inspect
          "<#{name} #{attrs.map{ |k, v| "#{k}: #{v}"}.join(', ')}>"
        end
      end

      module InstanceMethods
        def initialize(attributes = {})
          self.attributes = attributes
        end

        def attributes
          attribute_names.each_with_object({}) { |name, attrs|
            attrs[name] = read_attribute(name)
          }
        end

        def attributes=(attrs)
          attrs.each { |name, value|
            method = :"#{name}="
            if respond_to? method
              send(method, value)
            else
              message = "Was trying to set not existing attribute #{name.inspect} to #{value.inspect}"
              DaisybillApi.logger.debug message
            end
          }
        end

        def to_params
          attribute_names.each_with_object({}) { |name, attrs|
            attr = read_attribute(name)
            if attr && self.class.attrs[name].is_a?(Class)
              attrs["#{name}_attributes"] = attr.to_params
            else
              attrs[name] = attr
            end
          }
        end

        def inspect
          "<#{self.class.name} #{attributes.map { |k, v| "#{k}: #{v.inspect}" }.join(', ')}>"
        end

        private

        def read_attribute(name)
          values[name.to_sym]
        end

        def write_attribute(name, value)
          values[name.to_sym] = value
        end

        def attribute_names
          self.class.attribute_names
        end

        def values
          @values ||= {}
        end
      end
    end
  end
end
