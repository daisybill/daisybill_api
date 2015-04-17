require 'spec_helper'

describe DaisybillApi::Models::Attachment do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :document_url, :inactive, :report_type, :document,
    :bill_id, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :report_type, :document
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/attachments', bill_id: '/bills'
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
