module DaisybillApi
  module Ext
    module CRUD
      module Index
        module ClassMethods
          def all(options = {})
            id = options[@prefix_property]
            c = client(:get, index_path(id), options)

            if c.success?
              DaisybillApi::Ext::PageableCollection.new(
                c.response[plural_key.to_s].map { |attributes|
                  instance = new(attributes)
                  instance.send("#{prefix_property}=", id) if path_prefix?
                  instance
                },
                {
                  headers: c.headers,
                  params: options,
                  resource_class: self
                }
              )
            else
              DaisybillApi::Ext::PageableCollection.new([])
            end
          end
        end

        module InstanceMethods
        end
      end
    end
  end
end
