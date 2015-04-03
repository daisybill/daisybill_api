require 'spec_helper'

describe DaisybillApi::Models::Injury do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :description, :claim_number, :adj_number,
    :start_date, :end_date, :updated_at, :created_at,
    claims_administrator: [:id, :name], employer: [:name]
  it_behaves_like DaisybillApi::Ext::Attributes::ReadOnly, :id, :patient_id, :created_at, :updated_at,
    claims_administrator: []
  it_behaves_like DaisybillApi::Ext::CRUD, :all, :find, :create, :update, '/injuries',
    patient_id: '/patients'
  it_behaves_like DaisybillApi::Ext::Associations
  it_behaves_like DaisybillApi::Ext::Associations::BelongsTo, DaisybillApi::Models::Patient
end
