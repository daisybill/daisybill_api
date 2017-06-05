require "spec_helper"

describe DaisybillApi::Models::BillMailingAddress do
  it_behaves_like DaisybillApi::Ext::Attributes, :name, :submission_type, :company, :created_at, :updated_at,
    address: :model, bill_treatment_types: :collection
end
