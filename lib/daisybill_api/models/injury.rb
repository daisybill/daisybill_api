module DaisybillApi
  module Models
    class Injury < DaisybillApi::Models::Base
      path_prefix "/patients", :patient_id
      rest_actions :index, :show, :create, :update, :destroy

      attributes(
        id: :integer,
        claims_administrator: DaisybillApi::Models::ClaimsAdministrator,
        payer: DaisybillApi::Models::Payer,
        review_status: :string,
        review_errors: [:string],
        diagnosis_codes: [:string],
        contacts: [DaisybillApi::Models::Contact],
        readonly: true
      )
      attributes(
        description: :string,
        claim_number: :string,
        adj_number: :string,
        start_date: :date,
        end_date: :date,
        claims_administrator_id: :integer, #TODO: think how to connect it with claims_administrator attribute
        payer_id: :integer,
        employer: DaisybillApi::Models::Employer
      )

      link :patient, class: "Patient"
      has_many :bills, class: "Bill"
    end
  end
end
