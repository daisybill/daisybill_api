module DaisybillApi
  module Models
    class ErrorReport < DaisybillApi::Models::Base
      path_prefix '/bills', :bill_id
      rest_actions :index, :show, :create

      attributes(
        id:                    :integer,
        error_type:            :string,
        comment:               :string,
        name:                  :string,
        telephone:             :string,
        role:                  :string,
        call_reference_number: :string,
        readonly:              true
      )

      attributes(
        error_type:            :string,
        comment:               :string,
        name:                  :string,
        telephone:             :string,
        role:                  :string,
        call_reference_number: :string,
      )

      link :bill, class: 'Bill'
    end
  end
end
