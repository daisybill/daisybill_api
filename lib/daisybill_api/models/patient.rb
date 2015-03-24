module DaisybillApi
  module Models
    class Patient < DaisybillApi::Models::Base
      attributes(
        id: :integer,
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
    end
  end
end
