module DaisybillApi
  module Models
    class PharmacyBill < DaisybillApi::Models::Base
      path_prefix '/injuries', :injury_id
      rest_actions :index, :show, :create, :update, :destroy

      attributes(
        id: :integer,
        status: :string,
        charge_cents: :integer,
        expected_payment_cents: :integer,
        allowed_cents: :integer,
        balance_due_cents: :integer,
        review_status: :string,
        review_errors: [:string],
        readonly: true
      )

      attributes(
        product_type: :string,
        date_of_service: :date,
        prescription_date: :date,
        fill_number: :integer,
        prescription_number: :string,
        days_supply: :integer,
        dispense_as_written_code: :integer,
        unit_of_measurement: :string,
        authorization_number: :string,
        compound_name: :string,
        dosage_form: :integer,
        route_of_administration: :integer,
        number_of_containers: :integer,
        service_line_items: [DaisybillApi::Models::ServiceLineItem]
      )

      link :injury, class: 'Injury'
      link :place_of_service, class: 'PlaceOfService'
      link :prescribing_provider, class: 'PrescribingProvider'

      has_many :attachments, class: 'Attachment'
      has_many :bill_payments, class: 'BillPayment'
      has_many :bill_submissions, class: 'BillSubmission'
    end
  end
end
