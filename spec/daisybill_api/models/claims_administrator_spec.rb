require 'spec_helper'

describe DaisybillApi::Models::ClaimsAdministrator do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs
  it_behaves_like DaisybillApi::Ext::Associations, :payers
  it_behaves_like DaisybillApi::Ext::CRUD, :all, '/claims_administrators'
end
