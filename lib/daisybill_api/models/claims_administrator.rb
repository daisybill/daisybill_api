module DaisybillApi
  module Models
    class ClaimsAdministrator < DaisybillApi::Models::Base
      rest_actions :index

      attribute :id, :integer, readonly: true
      attributes(
        name: :string
      )
    end
  end
end
