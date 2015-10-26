module DaisybillApi
  module Ext
    module CRUD
      module Destroy
        # @private
        module ClassMethods; end

        module InstanceMethods
          # === Deleting records
          #
          #   bill = DaisybillApi::Models::Bill.find(12) # => <DaisybillApi::Models::Bill id: 12>
          #   bill.destroy # => true
          #   DaisybillApi::Models::Bill.find(12) # => nil
          #
          # Some records will not be deletable depending on their conditions:
          #
          #   bill = DaisybillApi::Models::Bill.find(1) # => <DaisybillApi::Models::Bill id: 1...>
          #   bill.status  # => "done"
          #   bill.destroy # => false
          #   bill.errors.full_messages # => ["Bill is not deletable"]
          def destroy
            @destroyed = send_data :delete, show_path
          end
        end
      end
    end
  end
end
