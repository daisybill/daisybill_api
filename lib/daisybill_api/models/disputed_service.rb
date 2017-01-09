module DaisybillApi
  module Models
    class DisputedService < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        readonly: true
      )

      attributes(
        service_line_item_id: :integer,
        reason: :string,
        authorized: :boolean,
        supporting_documentation_attached: :boolean
      )
    end
  end
end
