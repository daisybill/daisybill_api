module DaisybillApi
  module Ext
    module CRUD
      module Create
        module ClassMethods
          # === Creating a record
          #
          #   DaisybillApi::Models::Patient.create(
          #     first_name: "Johnny",
          #     last_name: "Smith",
          #     billing_provider_id: 14
          #   )
          #   # => <DaisybillApi::Models::Patient billing_provider_id: 14 ...>
          #
          #
          # === Creating a Bill
          #
          #   bp = DaisybillApi::Models::BillingProvider.find(14)
          #   # => <DaisybillApi::Models::BillingProvider id: 14...>
          #   pos = bp.places_of_service.first
          #   # => <DaisybillApi::Models::PlaceOfService billing_provider_id: 14...>
          #   rp = bp.rendering_providers.first
          #   # => <DaisybillApi::Models::RenderingProvider billing_provider_id: 14...>
          #
          #   sli = DaisybillApi::Models::ServiceLineItem.new(
          #     procedure_code: "S9981",
          #     units: 1,
          #     modifier_codes: ["93", "17"],
          #     diagnosis_code_1: "72700",
          #     custom_unit_charge_cents: 12345
          #   )
          #   # => <DaisybillApi::Models::ServiceLineItem...>
          #
          #   bill = DaisybillApi::Models::Bill.new(
          #     injury_id: 345,
          #     date_of_service: "2015-01-01",
          #     rendering_provider_id: rp.id,
          #     place_of_service_id: pos.id,
          #     diagnosis_codes: ["72700"],
          #     diagnosis_type: "Icd10",
          #     service_line_items: [sli]
          #   )
          #   # => <DaisybillApi::Models::Bill...>
          #
          #   bill.save
          #   # => true
          #
          # @param attributes [Hash]
          # @return [Object]
          def create(attributes = {})
            instance = new(attributes)
            instance.create
            instance
          end
        end

        module InstanceMethods
          # == Creating or Updating a record
          #
          # === Creating a record
          #
          #   pt = DaisyBillApi::Models::Patient.new(
          #     billing_provider_id: 14,
          #     first_name: "Johnny",
          #     last_name: "Smith",
          #     ssn: "123456789",
          #     gender: "Male"
          #   )
          #
          #   pt.save # => true
          #
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
          #
          # === Inspecting errors
          #
          #   pt = DaisybillApi::Models::Patient.new(billing_provider_id: 14, first_name: "Johnny")
          #
          #   pt.save # => false
          #
          #   pt.errors.full_messages # => ["Last name can't be blank"]
          def save
            return create if new_record?
            return update if respond_to? :update
            message = "#save method is not supported for saved record"
            DaisybillApi.logger.error message
            raise NotImplementedError.new message
          end

          # @private
          def create
            send_data :post, index_path
          end
        end
      end
    end
  end
end
