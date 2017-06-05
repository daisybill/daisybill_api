module DaisybillApi
  module Models
    class ServiceLineItemPayment < DaisybillApi::Models::Base
      attributes(
        service_line_item_id: :integer,
        procedure_code: :string,
        units: :float,
        payment_amount_cents: :integer,
        claim_adjustment_reasons: [DaisybillApi::Models::ClaimAdjustmentReason],
        readonly: true
      )
    end
  end
end
