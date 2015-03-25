module DaisybillApi
  module Models
    class Address
      include DaisybillApi::Ext::Attributes

      attributes(
        id: :integer,
        address_1: :string,
        address_2: :string,
        city: :string,
        state: :string,
        zip_code: :string
      )
    end
  end
end
