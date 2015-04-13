require 'spec_helper'

describe DaisybillApi::Models::PlaceOfService do
  it_behaves_like DaisybillApi::Ext::Attributes, :name, :nick_name, :county, :npi, :active,
    :authorization_telephone_number, :authorization_fax_number, :place_of_service_type, address: :model

  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :billing_provider_id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/places_of_service', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end

