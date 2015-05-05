module DaisybillApi
  module Models
    class Attachment < DaisybillApi::Models::Base
      rest_actions :index, :create, :update, :show, :destroy
      path_prefix '/bills', :bill_id

      attributes(
        id: :integer,
        document_url: :string,
        inactive: :boolean,
        readonly: true
      )

      attributes(
        report_type: :string,
        document: :attachment
      )

      link :bill, class: 'Bill', foreign_key: false
    end
  end
end
