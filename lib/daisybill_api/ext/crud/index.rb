module DaisybillApi
  module Ext
    module CRUD
      module Index
        module ClassMethods
          def all(*ids)
            c = client :get, index_path(*ids)
            return [] unless c.success?
            c.response[plural_key.to_s].map { |attributes|
              instance = new(attributes)
              instance.send("#{prefix_property}=", ids.first) if path_prefix?
              instance
            }
          end
        end

        module InstanceMethods
        end
      end
    end
  end
end
