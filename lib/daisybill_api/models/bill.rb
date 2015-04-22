module DaisybillApi
  module Models
    class Bill < DaisybillApi::Models::Base
      path_prefix '/injuries', :injury_id
      rest_actions :index, :show, :create, :update

      attributes(
        id: :integer,
        status: :string,
        charge_cents: :integer,
        expected_payment_cents: :integer,
        allowed_cents: :integer,
        balance_due_cents: :integer,
        write_off_cents: :integer,
        review_status: :string,
        review_errors: [:string],
        readonly: true,
      )

      attributes(
        date_of_service: :date,
        authorization_number: :string,
        admission_date: :date,
        practice_bill_id: :string,
        additional_information: :string,
        diagnosis_codes: [:string],
        service_line_items: [DaisybillApi::Models::ServiceLineItem]
      )

      link :injury, class: 'Injury', foreign_key: false
      link :place_of_service, class: 'PlaceOfService'
      link :rendering_provider, class: 'RenderingProvider'
      link :referring_provider, class: 'ReferringProvider'
      link :supervising_provider, class: 'RenderingProvider'

      has_many :bill_submissions, class: 'BillSubmission'
      has_many :attachments, class: 'Attachment'
    end
  end
end
