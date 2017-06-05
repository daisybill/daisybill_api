module DaisybillApi
  module Models
    class Task < DaisybillApi::Models::Base
      path_prefix "/bills", :bill_id
      rest_actions :index, :show, :create, :update

      attributes(
        id: :integer,
        readonly: true
      )

      attributes(
        assigned_user_id: :integer,
        bill_id: :integer,
        completed_by_id: :integer,
        completed_on: :date,
        due_date: :date,
        message: :string
      )

      link :assigned_user, class: "User"
      link :bill, class: "Bill"
      link :completed_by, class: "User"
    end
  end
end
