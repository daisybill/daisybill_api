module DaisybillApi
  module Models
    class PrescribingProvider < DaisybillApi::Models::Base
      path_prefix "/billing_providers", :billing_provider_id
      rest_actions :index, :show, :create, :update

      attribute :id, :integer, readonly: true
      attributes(
        first_name: :string,
        last_name: :string,
        middle_initial: :string,
        suffix: :string,
        npi: :string,
        address: DaisybillApi::Models::Address
      )

      link :billing_provider, class: "BillingProvider"
    end
  end
end
