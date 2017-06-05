require "spec_helper"

describe DaisybillApi::Models::User do
  it_behaves_like DaisybillApi::Ext::Attributes,
    :id,
    :first_name,
    :last_name,
    :email,
    :active,
    :created_at,
    :updated_at

  it_behaves_like DaisybillApi::Ext::CRUD, :find, "/users"
end
