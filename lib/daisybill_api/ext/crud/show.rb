module DaisybillApi
  module Ext
    module CRUD
      module Show
        module ClassMethods
          def find(id)
            c = client :get, show_path(id)
            new(c.response) if c.success?
          end
        end

        module InstanceMethods
        end
      end
    end
  end
end
