module DaisybillApi
  module Models
    class Employer
      include DaisybillApi::Ext::Attributes

      attributes(
        id: :integer,
        name: :string,
        address: DaisybillApi::Models::Address
      )
    end
  end
end
