module DaisybillApi
  module Models
    class Address
      extend DaisybillApi::Ext::Attributes::ClassMethods
      include DaisybillApi::Ext::Attributes::InstanceMethods

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
