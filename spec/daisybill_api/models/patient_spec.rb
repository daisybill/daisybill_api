require 'spec_helper'

describe DaisybillApi::Models::Patient do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :middle_initial, :suffix,
    :gender, :practice_internal_id, :date_of_birth, :ssn, :telephone, :created_at, :updated_at,
    :billing_provider_id, :review_status, review_errors: :collection, review_warnings: :collection, address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :first_name, :last_name, :gender, :date_of_birth,
    :ssn, :address_attributes, :suffix, :middle_initial, :practice_internal_id, :telephone,
    :billing_provider_id
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, :destroy, :search, '/patients',
    billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations, :injuries
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end
