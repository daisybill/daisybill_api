module DaisybillApi
  module Models
    class PlaceOfService < DaisybillApi::Models::Base
      def self.plural_key
        'places_of_service'
      end

      path_prefix '/billing_providers', :billing_provider_id
      rest_actions :index, :show, :create, :update

      attribute :id, :integer, readonly: true

      attributes(
        name: :string,
        nick_name: :string,
        county: :string,
        npi: :string,
        active: :boolean,
        authorization_telephone_number: :string,
        authorization_fax_number: :string,
        place_of_service_type: :string,
        address: DaisybillApi::Models::Address
      )

      link :billing_provider, class: 'BillingProvider'
    end
  end
end

