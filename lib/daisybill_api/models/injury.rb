module DaisybillApi
  module Models
    class Injury < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        description: :string,
        claim_number: :string,
        adj_number: :string,
        start_date: :date,
        end_date: :date,
        claims_administrator: DaisybillApi::Models::ClaimsAdministrator,
        employer: DaisybillApi::Models::Employer
      )

      belongs_to :patient, class: 'Patient'
    end
  end
end
