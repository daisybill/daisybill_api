require 'spec_helper'

describe DaisybillApi::Models::BillingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :fein, :npi, :telephone, :fax_number,
    :created_at, :updated_at, :dol_provider_number, physical_address: :model, pay_to_address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations, :patients
  it_behaves_like DaisybillApi::Ext::Associations, :rendering_providers
  it_behaves_like DaisybillApi::Ext::Associations, :referring_providers
  it_behaves_like DaisybillApi::Ext::Associations, :prescribing_providers
  it_behaves_like DaisybillApi::Ext::Associations, :places_of_service
  it_behaves_like DaisybillApi::Ext::Associations, :attachments
  it_behaves_like DaisybillApi::Ext::Associations, :remittances
  it_behaves_like DaisybillApi::Ext::Links
end
