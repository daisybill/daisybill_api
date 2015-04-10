require 'spec_helper'

describe DaisybillApi::Models::Patient do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :mi, :suffix, :gender,
    :practice_internal_id, :date_of_birth, :ssn, :telephone, :created_at, :updated_at,
    :review_status, review_errors: :collection, address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :created_at, :updated_at,
    :review_status, review_errors: :collection
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/patients',
    billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations, :injuries
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end
