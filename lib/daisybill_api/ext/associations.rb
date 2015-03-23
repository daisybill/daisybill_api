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
          self.attribute self.foreign_key, :integer
          validates self.foreign_key, presence: true

          clazz = modulize options[:class]
          define_method name do
            clazz.constantize.find(self.send fk)
          end

          metaclass.instance_eval do
            alias_method :old_index_path, :index_path
            define_method :index_path do |id|
              "#{clazz.constantize.show_path(id)}#{old_index_path}"
            end

            alias_method :old_all, :all
            define_method :all do |id|
              c = client :get, index_path(id)
              process_collection c
            end
          end

          define_method :index_path do
            self.class.index_path(self.send fk)
          end
        end

        private

        def metaclass
          class << self
            self
          end
        end

        def modulize(name)
          "DaisybillApi::Models::#{name}"
        end
      end

      module InstanceMethods
      end
    end
  end
end
