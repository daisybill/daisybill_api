require 'spec_helper'

describe DaisybillApi::Models::ClaimsAdministrator do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :name
end
