module DaisybillApi
  module Ext
    module CRUD
      module Destroy
        module ClassMethods
        end

        module InstanceMethods
          def destroy
            @destroyed = send_data :delete, show_path
          end
        end
      end
    end
  end
end
