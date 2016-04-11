require 'spec_helper'

describe DaisybillApi::Models::Payer do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name, :description, :main, :claims_administrator_id,
    :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs
  it_behaves_like DaisybillApi::Ext::CRUD, :all, '/payers', claims_administrator_id: '/claims_administrators'
end
