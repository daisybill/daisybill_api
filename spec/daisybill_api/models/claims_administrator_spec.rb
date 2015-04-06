require 'spec_helper'

describe DaisybillApi::Models::ClaimsAdministrator do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :created_at, :updated_at
end
