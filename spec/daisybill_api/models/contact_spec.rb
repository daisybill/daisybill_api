require 'spec_helper'

describe DaisybillApi::Models::Contact do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :first_name, :last_name, :company, :role, :telephone,
    :email, :fax, :created_at, :updated_at, address: :model
end
