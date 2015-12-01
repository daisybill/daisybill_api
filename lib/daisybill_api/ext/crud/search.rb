module DaisybillApi
  module Ext
    module CRUD
      module Search
        module ClassMethods
          # Retrieves a list of records
          #
          #   @patients = DaisybillApi::Models::Patient.search(billing_provider_id: 2)
          #   # => #<DaisybillApi::Ext::PageableCollection>
          #
          # @param [Hash] options
          # @return [Object] a {DaisybillApi::Ext::PageableCollection PageableCollection} that includes Enumerable
          def search(options = {})
            id = options[@prefix_property]
            c = client(:get, search_path(id), options)

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

        # @private
        module InstanceMethods; end
      end
    end
  end
end
