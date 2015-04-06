require 'spec_helper'

describe DaisybillApi::Models::Address do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :address_1, :address_2, :city, :state, :zip_code,
      :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :created_at, :updated_at
end
