require "spec_helper"

describe DaisybillApi::Models::Employer do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :created_at, :updated_at,
    address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :id, :name, :address_attributes
end
