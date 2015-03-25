module DaisybillApi
  module Models
    class Employer
      include DaisybillApi::Ext::Attributes

      attributes(
        name: :string,
        address: DaisybillApi::Models::Address
      )
    end
  end
end
