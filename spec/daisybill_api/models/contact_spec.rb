require 'spec_helper'

describe DaisybillApi::Models::Contact do
  it_behaves_like DaisybillApi::Ext::Attributes,
    :id,
    :injury_id,
    :type,
    :first_name,
    :last_name,
    :company,
    :role,
    :telephone,
    :email,
    :fax,
    :created_at,
    :updated_at,
    address: :model

  it_behaves_like DaisybillApi::Ext::Attributes::SendAs,
    :injury_id,
    :first_name,
    :last_name,
    :company,
    :telephone,
    :email,
    :fax,
    :type,
    :address_attributes

  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, "/contacts", injury_id: "/injuries"
  it_behaves_like DaisybillApi::Ext::Links, injury: DaisybillApi::Models::Injury
end
