module DaisybillApi
  module Models
    class BillSubmission < DaisybillApi::Models::Base
      rest_actions :index, :show, :create
      path_prefix '/bills', :bill_id

      attributes(
        comment: :string,
        supporting_document_ids: [:integer]
      )

      attributes(
        id: :integer,
        type: :string,
        mode: :string,
        claims_administrator: DaisybillApi::Models::ClaimsAdministrator,
        readonly: true
      )

      link :bill, class: 'Bill'
    end
  end
end
