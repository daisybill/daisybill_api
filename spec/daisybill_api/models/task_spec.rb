require "spec_helper"

describe DaisybillApi::Models::Task do
  it_behaves_like DaisybillApi::Ext::Attributes,
    :id,
    :created_at,
    :updated_at,
    :bill_id,
    :message,
    :assigned_user_id,
    :due_date,
    :completed_by_id,
    :completed_on

  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, "/tasks", bill_id: "/bills"
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
  it_behaves_like DaisybillApi::Ext::Links, completed_by: DaisybillApi::Models::User
  it_behaves_like DaisybillApi::Ext::Links, assigned_user: DaisybillApi::Models::User
end
