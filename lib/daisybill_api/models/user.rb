module DaisybillApi
  module Models
    class User < DaisybillApi::Models::Base
      rest_actions :show, :index

      attributes(
        id: :integer,
        first_name: :string,
        last_name: :string,
        email: :string,
        active: :boolean,
        readonly: true
      )
    end
  end
end
