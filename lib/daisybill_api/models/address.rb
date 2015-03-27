module DaisybillApi
  module Models
    class Address
      include DaisybillApi::Ext::Attributes

      attribute :id, :integer, readonly: true
      attributes(
        address_1: :string,
        address_2: :string,
        city: :string,
        state: :string,
        zip_code: :string
      )
    end
  end
end
