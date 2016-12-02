module DaisybillApi
  module Models
    class ClaimNumberVerification < DaisybillApi::Models::Base
      class << self
        def index_path(*_)
          "/claim_number_verifications"
        end
      end

      rest_actions :create

      attributes(
        matches: :boolean,
        claim_number_patterns_present: :boolean,
        readonly: true
      )

      attributes(
        claim_number: :string,
        resource_type: :string,
        resource_id: :integer,
      )

      private

      def id; end
    end
  end
end
