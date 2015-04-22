module DaisybillApi
  module Models
    class ClaimsAdministrator < DaisybillApi::Models::Base
      rest_actions :index

      attributes(
        id: :integer,
        name: :string,
        readonly: true
      )
    end
  end
end
