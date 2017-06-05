require "spec_helper"

describe DaisybillApi::Models::PaperEor do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :remittance_id, :created_at,
    :updated_at, review_errors: :collection, review_warnings: :collection
  it_behaves_like DaisybillApi::Ext::CRUD, :all, "/paper_eors", remittance_id: "/remittances"
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Links, remittance: DaisybillApi::Models::Remittance
end
