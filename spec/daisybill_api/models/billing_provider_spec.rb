require 'spec_helper'

describe DaisybillApi::Models::BillingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :fein, :npi, :telephone, :fax_number,
    :created_at, :updated_at,
    physical_address: :model,
    pay_to_address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations, :patients
  it_behaves_like DaisybillApi::Ext::Links
end
