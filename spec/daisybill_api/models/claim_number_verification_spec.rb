require 'spec_helper'

describe DaisybillApi::Models::ClaimNumberVerification do
  it_behaves_like DaisybillApi::Ext::Attributes, :matches, :claim_number_patterns_present, :updated_at, :created_at,
    :resource_id, :resource_type, :claim_number
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :resource_id, :resource_type, :claim_number
  it_behaves_like DaisybillApi::Ext::CRUD, :create, "/claim_number_verifications"
end
