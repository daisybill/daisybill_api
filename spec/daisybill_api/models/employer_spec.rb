require 'spec_helper'

describe DaisybillApi::Models::Employer do
  it_behaves_like DaisybillApi::Ext::Attributes, :name, :created_at, :updated_at,
    address: [:id, :address_1, :address_2, :city, :state, :zip_code, :created_at, :updated_at]
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :created_at, :updated_at
end
