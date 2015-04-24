require 'spec_helper'

describe DaisybillApi::Models::BillPayment do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :payment_amount_cents, :check_amount, :check_number,
    :check_effective_date, :payment_source, :created_at, :updated_at, :bill_id, :bill_submission_id

  it_behaves_like DaisybillApi::Ext::CRUD, :all, '/bill_payments', bill_id: '/bills'

  it_behaves_like DaisybillApi::Ext::Links, bill: DaisybillApi::Models::Bill,
    bill_submission: DaisybillApi::Models::BillSubmission
end
