require 'spec_helper'

describe DaisybillApi::Models::Employer do
  it_behaves_like DaisybillApi::Ext::Attributes, :name, :created_at, :updated_at,
    address: :model
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :created_at, :updated_at
end
