module DaisybillApi
  module Models
    class Attachment < DaisybillApi::Models::Base
      rest_actions :index, :create, :update, :show
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
    end
  end
end
