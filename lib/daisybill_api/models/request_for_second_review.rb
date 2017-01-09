module DaisybillApi
  module Models
    class RequestForSecondReview < DaisybillApi::Models::Base
      rest_actions :create
      self.path = '/requests_for_second_review'
      path_prefix '/bills', :bill_id

      attributes(
        id: :integer,
        bill_submission_id: :integer,
        readonly: true
      )

      attributes(
        disputed_services: [DaisybillApi::Models::DisputedService]
      )

      link :bill, class: 'Bill'
    end
  end
end
