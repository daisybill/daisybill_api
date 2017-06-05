require "spec_helper"

describe DaisybillApi::Models::BillSubmission do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :type, :mode, :bill_id,
    :created_at, :updated_at, :comment, :supporting_document_ids, claims_administrator: :model

  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :comment, :supporting_document_ids, :bill_id

  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, "/bill_submissions", bill_id: "/bills"
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
