module DaisybillApi
  module Models
    class ClaimsAdministrator
      include DaisybillApi::Ext::Attributes

      attributes(
        id: :integer,
        name: :string
      )
    end
  end
end
