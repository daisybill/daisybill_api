module DaisybillApi
  module Models
    class Attachment < DaisybillApi::Models::Base
      rest_actions :index, :create, :update, :show, :destroy
      path_prefix '/bills', :bill_id

      attributes(
        id: :integer,
        document_url: :string,
        inactive: :boolean,
        review_status: :string,
        review_errors: [:string],
        review_warnings: [:string],
        document_file_name: :string,
        document_content_type: :string,
        document_file_size: :integer,
        readonly: true
      )

      attributes(
        report_type: :string,
        document: :attachment
      )

      link :bill, class: 'Bill'
    end
  end
end
