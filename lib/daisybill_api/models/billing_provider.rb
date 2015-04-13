module DaisybillApi
  module Models
    class BillingProvider < DaisybillApi::Models::Base
      rest_actions :index, :show

      attribute :id, :integer, readonly: true
      attributes(
        name: :string,
        fein: :string,
        npi: :string,
        telephone: :string,
        fax_number: :string,
        physical_address: DaisybillApi::Models::Address,
        pay_to_address: DaisybillApi::Models::Address
      )

      has_many :patients, class: 'Patient'
      has_many :rendering_providers, class: 'RenderingProvider'
      has_many :referring_providers, class: 'ReferringProvider'
    end
  end
end
