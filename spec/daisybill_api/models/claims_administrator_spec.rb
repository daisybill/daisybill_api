require "spec_helper"

describe DaisybillApi::Models::ClaimsAdministrator do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :created_at, :updated_at, :description
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs
  it_behaves_like DaisybillApi::Ext::Associations, :payers
  it_behaves_like DaisybillApi::Ext::Associations, :bill_mailing_addresses
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, "/claims_administrators"
end
