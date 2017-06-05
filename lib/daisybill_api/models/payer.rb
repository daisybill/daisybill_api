module DaisybillApi
  module Models
    class Payer < DaisybillApi::Models::Base
      path_prefix "/claims_administrators", :claims_administrator_id
      rest_actions :index, :show

      attributes(
        id: :integer,
        name: :string,
        description: :string,
        main: :boolean,
        readonly: true
      )

      has_many :bill_mailing_addresses, class: "BillMailingAddress", set_path: true
    end
  end
end
