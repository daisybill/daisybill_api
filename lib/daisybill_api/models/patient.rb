module DaisybillApi
  module Models
    class Patient < DaisybillApi::Models::Base
      path_prefix '/billing_providers', :billing_provider_id
      rest_actions :index, :show, :create, :update

      attributes(
        id: :integer,
        review_status: :string,
        review_errors: [:string],
        readonly: true
      )
      attributes(
        first_name: :string,
        last_name: :string,
        mi: :string,
        suffix: :string,
        gender: :string,
        practice_internal_id: :string,
        date_of_birth: :date,
        ssn: :string,
        telephone: :string,
        address: DaisybillApi::Models::Address
      )

      belongs_to :billing_provider, class: 'BillingProvider'
      has_many :injuries, class: 'Injury'
    end
  end
end
