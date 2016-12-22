require 'spec_helper'

describe DaisybillApi::Models::Remittance do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :check_number, :check_amount_cents, :billing_provider_id, :effective_date, :deposited_on, :billing_provider_id, :created_at, :updated_at, bill_payments: :collection
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, '/remittances', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links, billing_provider: DaisybillApi::Models::BillingProvider
end
