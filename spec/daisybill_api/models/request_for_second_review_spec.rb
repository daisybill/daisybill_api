require "spec_helper"

describe DaisybillApi::Models::RequestForSecondReview do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :bill_submission_id, :bill_id, :created_at, :updated_at,
    disputed_services: :collection
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :bill_id, :disputed_services_attributes

  it_behaves_like DaisybillApi::Ext::CRUD, :create, "/requests_for_second_review", bill_id: "/bills"
  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill
end
