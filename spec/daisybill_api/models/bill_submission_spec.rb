require 'spec_helper'

describe DaisybillApi::Models::BillSubmission do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :type, :mode, :bill_id,
    :created_at, :updated_at, claims_administrator: :model

  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, '/bill_submissions', bill_id: '/bills'
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
