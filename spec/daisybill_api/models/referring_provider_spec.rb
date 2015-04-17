require 'spec_helper'

describe DaisybillApi::Models::ReferringProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :middle_initial, :suffix,
    :npi, :state_license_number, :active, :billing_provider_id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :first_name, :last_name, :npi, :state_license_number,
    :middle_initial, :suffix, :active
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/referring_providers', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end
