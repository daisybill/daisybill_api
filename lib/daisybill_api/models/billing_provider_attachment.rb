module DaisybillApi
  module Models
    class BillingProviderAttachment < DaisybillApi::Models::Base
      rest_actions :index
      self.path = '/attachments'
      path_prefix '/billing_providers', :billing_provider_id

      attributes(
        id: :integer,
        document_url: :string,
        inactive: :boolean,
        review_status: :string,
        review_errors: [:string],
        document_file_name: :string,
        document_content_type: :string,
        document_file_size: :integer,
        report_type: :string,
        document: :attachment,
        readonly: true
      )

      link :bill, class: 'Bill'
    end
  end
end
