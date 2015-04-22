module DaisybillApi
  module Models
    class ReferringProvider < DaisybillApi::Models::Base
      path_prefix '/billing_providers', :billing_provider_id
      rest_actions :index, :show, :create, :update

      attribute :id, :integer, readonly: true
      attributes(
        first_name: :string,
        last_name: :string,
        middle_initial: :string,
        suffix: :string,
        npi: :string,
        state_license_number: :string,
        active: :boolean
      )

      link :billing_provider, class: 'BillingProvider', foreign_key: false
    end
  end
end
