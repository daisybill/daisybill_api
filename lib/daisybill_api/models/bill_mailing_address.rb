module DaisybillApi
  module Models
    class BillMailingAddress < DaisybillApi::Models::Base
      rest_actions :index

      attributes(
        name: :string,
        submission_type: :string,
        company: :string,
        bill_treatment_types: [:string],
        address: DaisybillApi::Models::Address,
        readonly: true
     )
    end
  end
end
