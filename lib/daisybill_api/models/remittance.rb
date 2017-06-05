module DaisybillApi
  module Models
    class Remittance < DaisybillApi::Models::Base
      path_prefix "/billing_providers", :billing_provider_id
      rest_actions :index, :show, :create
      attributes id: :integer, readonly: true
      attributes(
        check_number: :string,
        check_amount_cents: :integer,
        effective_date: :date,
        deposited_on: :date,
        bill_payments: [DaisybillApi::Models::BillPayment]
      )

      has_many :paper_eors, class: "PaperEor"

      link :billing_provider, class: "BillingProvider"
    end
  end
end
