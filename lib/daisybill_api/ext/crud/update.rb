module DaisybillApi
  module Ext
    module CRUD
      module Update
        module ClassMethods
        end

        module InstanceMethods
          def save
            return update unless new_record?
            return create if respond_to? :create
            message = '#save method is not supported for new record'
            DaisybillApi.logger.error message
            raise NotImplementedError.new message
          end

          def update
            send_data :patch, show_path
          end
        end
      end
    end
  end
end
