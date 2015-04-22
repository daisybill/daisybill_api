module DaisybillApi
  module Models
    class ServiceLineItem < DaisybillApi::Models::Base
      attributes(
        id: :integer,
        charge_cents: :integer,
        expected_payment_cents: :integer,
        allowed_cents: :integer,
        balance_due_cents: :integer,
        write_off_cents: :integer,
        modifiers: [:string],
        readonly: true
      )

      attributes(
        procedure_code: :string,
        units: :float,
        supplemental_data: :string,
        diagnosis_code_1: :string,
        diagnosis_code_2: :string,
        diagnosis_code_3: :string,
        diagnosis_code_4: :string
      )
    end
  end
end
