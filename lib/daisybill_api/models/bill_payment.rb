module DaisybillApi
  module Models
    class BillPayment < DaisybillApi::Models::Base
      rest_actions :index, :show
      path_prefix "/bills", :bill_id

      attributes(
        id: :integer,
        check_amount: :integer,
        check_number: :string,
        check_effective_date: :date,
        payment_source: :string,
        claim_adjustment_reasons: [DaisybillApi::Models::ClaimAdjustmentReason],
        service_line_item_payments: [DaisybillApi::Models::ServiceLineItemPayment],
        readonly: true
      )

      attributes(
        service_line_items: [DaisybillApi::Models::ServiceLineItem],
        payer_claim_control_number: :integer,
        payment_amount_cents: :integer
      )

      link :bill_submission, class: "BillSubmission"
      link :bill, class: "Bill"
    end
  end
end
