module DaisybillApi
  module Ext
    module CRUD
      module Update
        # @private
        module ClassMethods; end

        module InstanceMethods

          # === Updating a record
          #
          #   pt = DaisybillApi::Models::Patient.find(12) # => <DaisybillApi::Models::Patient id: 12...>
          #
          #   pt.telephone                # => "2138888888"
          #
          #   pt.telephone = "2137777777" # => "2137777777"
          #
          #   pt.telephone                # => "2137777777"
          #
          #   pt.save # => true
          def save
            return update unless new_record?
            return create if respond_to? :create
            message = "#save method is not supported for new record"
            DaisybillApi.logger.error message
            raise NotImplementedError.new message
          end

          # @private
          def update
            send_data :patch, show_path
          end
        end
      end
    end
  end
end
