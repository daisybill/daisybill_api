require "spec_helper"

describe DaisybillApi::Models::Injury do
  EXT_ATTRIBUTES = [
    :id,
    :adj_number,
    :claim_number,
    :claims_administrator_id,
    :created_at,
    :description,
    :end_date,
    :patient_id,
    :payer_id,
    :review_status,
    :start_date,
    :updated_at,
  ].freeze

  EXT_ATTRIBUTE_TYPES = {
    claims_administrator: :model,
    employer:             :model,
    payer:                :model,
    contacts:        :collection,
    diagnosis_codes: :collection,
    review_errors:   :collection
  }.freeze

  EXT_SEND_AS_ATTRIBUTES = [
    :adj_number,
    :claim_number,
    :claims_administrator_id,
    :description,
    :employer_attributes,
    :end_date,
    :patient_id,
    :payer_id,
    :start_date
  ].freeze

  it_behaves_like DaisybillApi::Ext::Attributes, *EXT_ATTRIBUTES, EXT_ATTRIBUTE_TYPES
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, *EXT_SEND_AS_ATTRIBUTES

  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, :destroy, "/injuries", patient_id: "/patients"
  it_behaves_like DaisybillApi::Ext::Associations, :bills, :pharmacy_bills
  it_behaves_like DaisybillApi::Ext::Links, patient: DaisybillApi::Models::Patient
end
