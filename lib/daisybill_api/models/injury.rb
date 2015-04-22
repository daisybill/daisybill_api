module DaisybillApi
  module Models
    class Injury < DaisybillApi::Models::Base
      path_prefix '/patients', :patient_id
      rest_actions :index, :show, :create, :update

      attributes(
        id: :integer,
        claims_administrator: DaisybillApi::Models::ClaimsAdministrator,
        review_status: :string,
        review_errors: [:string],
        diagnosis_codes: [:string],
        readonly: true
      )
      attributes(
        description: :string,
        claim_number: :string,
        adj_number: :string,
        start_date: :date,
        end_date: :date,
        claims_administrator_id: :integer, #TODO: think how to connect it with claims_administrator attribute
        employer: DaisybillApi::Models::Employer
      )

      link :patient, class: 'Patient', foreign_key: false
      has_many :bills, class: 'Bill'
    end
  end
end
