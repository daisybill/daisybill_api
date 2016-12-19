module DaisybillApi
  module Models
    class Remittance < DaisybillApi::Models::Base
      path_prefix '/billing_providers', :billing_provider_id
      rest_actions :index

      attributes id: :integer, readonly: true
      attributes(
        check_number: :string,
        check_amount_cents: :integer,
        effective_date: :date,
        deposited_on: :date
      )

      link :billing_provider, class: 'BillingProvider'
    end
  end
end
