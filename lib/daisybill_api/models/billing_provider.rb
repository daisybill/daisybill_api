module DaisybillApi
  module Models
    class BillingProvider < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        name: :string,
        fein: :string,
        npi: :string,
        telephone: :string,
        fax_number: :string,
        physical_address: DaisybillApi::Models::Address,
        pay_to_address: DaisybillApi::Models::Address
      )

      has_many :patients, class: 'Patient'
    end
  end
end
