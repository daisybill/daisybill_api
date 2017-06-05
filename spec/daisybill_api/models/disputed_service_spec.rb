require "spec_helper"

describe DaisybillApi::Models::DisputedService do
  it_behaves_like DaisybillApi::Ext::Attributes, :id, :service_line_item_id, :reason, :authorized,
    :supporting_documentation_attached, :created_at, :updated_at
  it_behaves_like DaisybillApi::Ext::Attributes::SendAs, :service_line_item_id, :reason, :authorized,
    :supporting_documentation_attached
end
