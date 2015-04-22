require 'spec_helper'

describe DaisybillApi::Models::ServiceLineItem do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :units, :supplemental_data, :procedure_code,
    :diagnosis_code_1, :diagnosis_code_2, :diagnosis_code_3, :diagnosis_code_4, :charge_cents,
    :expected_payment_cents, :allowed_cents, :balance_due_cents, :write_off_cents, :created_at,
    :updated_at, modifiers: :collection
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :procedure_code, :units, :supplemental_data,
    :diagnosis_code_1, :diagnosis_code_2, :diagnosis_code_3, :diagnosis_code_4
end
