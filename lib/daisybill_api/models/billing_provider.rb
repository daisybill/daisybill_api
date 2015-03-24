module DaisybillApi
  module Models
    class BillingProvider < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        name: :string,
        fein: :string,
        npi: :string,
        telephone: :string,
        fax_number: :string
      )

      has_many :patients, class: 'Patient'
    end
  end
end
