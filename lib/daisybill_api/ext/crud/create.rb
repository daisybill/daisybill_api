module DaisybillApi
  module Ext
    module CRUD
      module Create
        module ClassMethods
          def create(attributes = {})
            instance = new(attributes)
            instance.create
            instance
          end
        end

        module InstanceMethods
          def save
            return create if new_record?
            return update if respond_to? :update
            message = '#save method is not supported for saved record'
            DaisybillApi.logger.error message
            raise NotImplementedError.new message
          end

          def create
            send_data :post, index_path
          end
        end
      end
    end
  end
end
