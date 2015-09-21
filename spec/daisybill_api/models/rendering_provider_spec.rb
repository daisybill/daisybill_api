require 'spec_helper'

describe DaisybillApi::Models::RenderingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :middle_initial, :suffix,
    :npi, :state_license_number, :taxonomy_code, :type_of_specialty, :active, :billing_provider_id,
    :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :first_name, :last_name, :npi, :state_license_number,
    :taxonomy_code, :type_of_specialty, :middle_initial, :suffix, :active, :billing_provider_id
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/rendering_providers', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end
