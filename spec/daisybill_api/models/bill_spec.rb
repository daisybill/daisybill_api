require "spec_helper"

describe DaisybillApi::Models::Bill do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :date_of_service, :authorization_number, :status,
    :admission_date, :practice_bill_id, :additional_information, :charge_cents, :expected_payment_cents,
    :allowed_cents, :balance_due_cents, :write_off_cents, :created_at, :updated_at, :injury_id,
    :place_of_service_id, :rendering_provider_id, :referring_provider_id, :supervising_provider_id,
    :review_status, :diagnosis_type, review_errors: :collection, review_warnings: :collection,
    diagnosis_codes: :collection, service_line_items: :collection
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :date_of_service, :place_of_service_id,
    :rendering_provider_id, :referring_provider_id, :supervising_provider_id, :authorization_number,
    :admission_date, :additional_information, :practice_bill_id, :diagnosis_type, :diagnosis_codes,
    :service_line_items_attributes, :injury_id
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, :destroy, :write_off, "/bills", injury_id: "/injuries"
  it_behaves_like DaisybillApi::Ext::Links, injury: DaisybillApi::Models::Injury,
    place_of_service: DaisybillApi::Models::PlaceOfService,
    rendering_provider: DaisybillApi::Models::RenderingProvider,
    referring_provider: DaisybillApi::Models::ReferringProvider,
    supervising_provider: DaisybillApi::Models::RenderingProvider
  it_behaves_like DaisybillApi::Ext::Associations, :bill_submissions
  it_behaves_like DaisybillApi::Ext::Associations, :attachments
  it_behaves_like DaisybillApi::Ext::Associations, :error_reports
end
