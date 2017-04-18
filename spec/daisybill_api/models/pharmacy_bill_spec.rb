require 'spec_helper'

describe DaisybillApi::Models::PharmacyBill do
  it_behaves_like DaisybillApi::Ext::Attributes,
    :id, :date_of_service, :authorization_number, :status, :product_type,
    :prescription_date, :fill_number, :prescription_number, :days_supply,
    :dispense_as_written_code, :unit_of_measurement, :compound_name, :practice_bill_id,
    :dosage_form, :route_of_administration, :charge_cents, :number_of_containers,
    :expected_payment_cents, :allowed_cents, :balance_due_cents, :created_at,
    :updated_at, :injury_id, :place_of_service_id, :prescribing_provider_id,
    :review_status, review_errors: :collection, review_warnings: :collection,
    service_line_items: :collection
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs,
    :date_of_service, :authorization_number, :product_type, :prescription_date,
    :fill_number, :prescription_number, :days_supply, :dispense_as_written_code,
    :unit_of_measurement, :compound_name, :practice_bill_id, :dosage_form,
    :route_of_administration, :number_of_containers, :injury_id, :place_of_service_id,
    :prescribing_provider_id, :service_line_items_attributes
  it_behaves_like DaisybillApi::Ext::CRUD,
    :all, :find, :create, :update, :destroy, :write_off,
    '/pharmacy_bills', injury_id: '/injuries'
  it_behaves_like DaisybillApi::Ext::Links,
    injury: DaisybillApi::Models::Injury,
    place_of_service: DaisybillApi::Models::PlaceOfService,
    prescribing_provider: DaisybillApi::Models::PrescribingProvider
  it_behaves_like DaisybillApi::Ext::Associations, :attachments
  it_behaves_like DaisybillApi::Ext::Associations, :bill_payments
  it_behaves_like DaisybillApi::Ext::Associations, :bill_submissions
end
