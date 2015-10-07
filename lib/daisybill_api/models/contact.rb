module DaisybillApi
  module Models
    class Contact
      include DaisybillApi::Ext::Attributes

      attributes(
        id: :integer,
        first_name: :string,
        last_name: :string,
        company: :string,
        role: :string,
        telephone: :string,
        email: :string,
        fax: :string,
        address: DaisybillApi::Models::Address
      )
    end
  end
end
