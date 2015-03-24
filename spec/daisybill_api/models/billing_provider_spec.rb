require 'spec_helper'

describe DaisybillApi::Models::BillingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :fein, :npi, :telephone, :fax_number,
    :created_at, :updated_at,
    physical_address: [:id, :address_1, :address_2, :city, :state, :zip_code],
    pay_to_address: [:id, :address_1, :address_2, :city, :state, :zip_code]
  it_behaves_like DaisybillApi::Ext::CRUD, '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::HasMany, DaisybillApi::Models::Patient
end
