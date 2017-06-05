require "spec_helper"

describe DaisybillApi::Models::ServiceLineItemPayment do
  it_behaves_like DaisybillApi::Ext::Attributes, :service_line_item_id, :procedure_code, :units, :payment_amount_cents,
    :created_at, :updated_at, claim_adjustment_reasons: :collection
end
