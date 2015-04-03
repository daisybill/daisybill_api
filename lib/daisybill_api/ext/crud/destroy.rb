module DaisybillApi
  module Ext
    module CRUD
      module Destroy
        module ClassMethods
        end

        module InstanceMethods
          def destroy
            c = client :delete, show_path
            @destroyed = c.success?
          end
        end
      end
    end
  end
end
