module DaisybillApi
  module Models
    class Patient < DaisybillApi::Models::Base
      path_prefix '/billing_providers', :billing_provider_id
      rest_actions :index, :show, :create, :update, :destroy, :search

      attributes(
        id: :integer,
        review_status: :string,
        review_errors: [:string],
        readonly: true
      )
      attributes(
        first_name: :string,
        last_name: :string,
        middle_initial: :string,
        suffix: :string,
        gender: :string,
        practice_internal_id: :string,
        date_of_birth: :date,
        ssn: :string,
        telephone: :string,
        address: DaisybillApi::Models::Address
      )

      has_many :injuries, class: 'Injury'

      link :billing_provider, class: 'BillingProvider'
    end
  end
end

