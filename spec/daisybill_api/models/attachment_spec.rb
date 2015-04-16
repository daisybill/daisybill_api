require 'spec_helper'

describe DaisybillApi::Models::Attachment do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :document_url, :inactive, :report_type, :document,
    :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :document_url, :inactive,
    :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/attachments', bill_id: '/bills'
end
