module DaisybillApi
  module Ext
    module CRUD
      module Index
        module ClassMethods
          # Retrieves a list of records
          #
          #   @patients = DaisybillApi::Models::Patient.all(billing_provider_id: 2)
          #   # => #<DaisybillApi::Ext::PageableCollection>
          #
          # @param [Hash] options
          # @return [Object] a {DaisybillApi::Ext::PageableCollection PageableCollection} that includes Enumerable
          def all(options = {})
            id = options[@prefix_property]

            if options[:path]
              c = client(:get, options.delete(:path), options)
            else
              c = client(:get, index_path(id), options)
            end

            if c.success?
              collection_key = options[:collection_key] || plural_key.to_s
              DaisybillApi::Ext::PageableCollection.new(
                c.response[collection_key].map { |attributes|
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
