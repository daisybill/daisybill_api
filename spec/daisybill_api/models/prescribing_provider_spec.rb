require "spec_helper"

describe DaisybillApi::Models::PrescribingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes,
    :id, :first_name, :last_name, :middle_initial, :suffix,
    :npi, :billing_provider_id, :created_at, :updated_at, address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs,
    :first_name, :last_name, :npi, :middle_initial,
    :suffix, :billing_provider_id, :address_attributes
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update,
    "/prescribing_providers", billing_provider_id: "/billing_providers"
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links,
    billing_provider: DaisybillApi::Models::BillingProvider
end
