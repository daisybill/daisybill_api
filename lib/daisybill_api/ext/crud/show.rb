module DaisybillApi
  module Ext
    module CRUD
      module Show
        module ClassMethods
          # === Retrieving a record
          #
          #   DaisybillApi::Models::BillingProvider.find(14) # => <DaisybillApi::Models::BillingProvider id: 14...>
          #
          # If a record is not found, nil is returned
          def find(id)
            c = client :get, show_path(id)
            new(c.response) if c.success?
          end
        end

        # @private
        module InstanceMethods; end
      end
    end
  end
end
