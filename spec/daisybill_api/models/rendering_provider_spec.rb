require 'spec_helper'

describe DaisybillApi::Models::RenderingProvider do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :middle_initial, :suffix,
        :npi, :state_license_number, :taxonomy_code, :active
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :billing_provider_id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/rendering_providers', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::BelongsTo, DaisybillApi::Models::BillingProvider
end
