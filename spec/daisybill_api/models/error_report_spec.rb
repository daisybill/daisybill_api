require 'spec_helper'

describe DaisybillApi::Models::ErrorReport do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :bill_id, :error_type, :comment,
    :name, :telephone, :role, :call_reference_number, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :bill_id, :error_type, :comment,
    :name, :telephone, :role, :call_reference_number
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, '/error_reports', bill_id: '/bills'
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
