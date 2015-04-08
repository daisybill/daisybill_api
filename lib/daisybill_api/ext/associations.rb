module DaisybillApi
  module Ext
    module Associations
      module ClassMethods #TODO: Think about creating Association classes or Routing class
        def foreign_key=(value)
          @foreign_key = value
        end

        def foreign_key
          @foreign_key
        end

        def has_many(name, options = {})
          clazz = modulize options[:class]
          define_method name do
            clazz.constantize.all(self.id)
          end
        end

        def belongs_to(name, options = {})
          self.foreign_key = fk = options[:foreign_key] || :"#{name}_id"

          clazz = modulize options[:class]
          define_method name do
            clazz.constantize.find(self.send fk)
          end
        end

        private

        def modulize(name)
          "DaisybillApi::Models::#{name}"
        end
      end

      def self.included(base)
        base.class_eval do
          include DaisybillApi::Ext::Associations::InstanceMethods
          extend DaisybillApi::Ext::Associations::ClassMethods
        end
      end

      module InstanceMethods
      end
    end
  end
end
