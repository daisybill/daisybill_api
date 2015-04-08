require 'spec_helper'

describe DaisybillApi::Models::Patient do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :mi, :suffix, :gender,
    :practice_internal_id, :date_of_birth, :ssn, :telephone, :created_at, :updated_at, :billing_provider_id,
    address: [:id, :address_1, :address_2, :city, :state, :zip_code]
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :billing_provider_id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/patients',
    billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::BelongsTo, DaisybillApi::Models::BillingProvider
  it_behaves_like DaisybillApi::Ext::Associations::HasMany, DaisybillApi::Models::Injury
end
