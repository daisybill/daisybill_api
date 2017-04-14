module DaisybillApi
  module Models
    class Contact < DaisybillApi::Models::Base
      path_prefix '/injuries', :injury_id
      rest_actions :index, :show, :create, :update

      attributes(
        id:        :integer,
        role:      :string,
        readonly:  true
      )

      attributes(
        first_name:      :string,
        last_name:       :string,
        company:         :string,
        telephone:       :string,
        email:           :string,
        fax:             :string,
        type:            :string,
        address:         DaisybillApi::Models::Address
      )

      link :injury, class: 'Injury'
    end
  end
end
