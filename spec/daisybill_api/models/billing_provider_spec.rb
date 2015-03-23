require 'spec_helper'

describe DaisybillApi::Models::BillingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :fein, :npi, :telephone, :fax_number
  it_behaves_like DaisybillApi::Ext::CRUD, '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::HasMany, DaisybillApi::Models::Patient
end
