module DaisybillApi
  module Models
    class BillingProvider < DaisybillApi::Models::Base
      rest_actions :index, :show

      attributes(
        id: :integer,
        name: :string,
        fein: :string,
        npi: :string,
        telephone: :string,
        fax_number: :string,
        physical_address: DaisybillApi::Models::Address,
        pay_to_address: DaisybillApi::Models::Address,
        readonly: true
      )

      has_many :patients, class: 'Patient'
      has_many :rendering_providers, class: 'RenderingProvider'
      has_many :referring_providers, class: 'ReferringProvider'
      has_many :places_of_service, class: 'PlaceOfService'
    end
  end
end
