require 'spec_helper'

describe DaisybillApi::Models::Injury do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :description, :claim_number, :adj_number,
    :start_date, :end_date, claims_administrator: [:id, :name], employer: [:name]
    #TODO: address attributes are missing for employer
  it_behaves_like DaisybillApi::Ext::CRUD, '/injuries', 'patient-id'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::BelongsTo, DaisybillApi::Models::Patient
end
