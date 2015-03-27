module DaisybillApi
  module Models
    class ClaimsAdministrator
      include DaisybillApi::Ext::Attributes

      attribute :id, :integer, readonly: true
      attributes(
        name: :string
      )
    end
  end
end
