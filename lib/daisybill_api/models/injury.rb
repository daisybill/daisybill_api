module DaisybillApi
  module Models
    class Injury < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        claims_administrator: DaisybillApi::Models::ClaimsAdministrator,
        readonly: true
      )
      attributes(
        description: :string,
        claim_number: :string,
        adj_number: :string,
        start_date: :date,
        end_date: :date,
        employer: DaisybillApi::Models::Employer
      )

      belongs_to :patient, class: 'Patient'
    end
  end
end
