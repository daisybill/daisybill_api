require 'spec_helper'

describe DaisybillApi::Models::Injury do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :description, :claim_number, :adj_number,
    :start_date, :end_date, :updated_at, :created_at, :patient_id, :claims_administrator_id, :review_status,
    review_errors: :collection, claims_administrator: :model, employer: :model, diagnosis_codes: :collection
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :description, :start_date, :end_date,
    :claims_administrator_id, :claim_number, :employer_attributes, :adj_number
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, :destroy, '/injuries', patient_id: '/patients'
  it_behaves_like DaisybillApi::Ext::Associations, :bills
  it_behaves_like DaisybillApi::Ext::Links, patient: DaisybillApi::Models::Patient
end
