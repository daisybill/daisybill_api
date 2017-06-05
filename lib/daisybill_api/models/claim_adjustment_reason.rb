module DaisybillApi
  module Models
    class ClaimAdjustmentReason < DaisybillApi::Models::Base
      attributes(
        code: :string,
        amount_cents: :integer,
        description: :string
      )
    end
  end
end
