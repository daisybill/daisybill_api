require 'spec_helper'

describe DaisybillApi::Models::BillingProviderAttachment do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :document_url, :inactive, :report_type, :document,
    :billing_provider_id, :bill_id, :created_at, :updated_at, :review_status, :document_file_name,
    :document_content_type, :document_file_size, review_errors: :collection

  it_behaves_like DaisybillApi::Ext::CRUD, :all, '/attachments', billing_provider_id: '/billing_providers'
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
