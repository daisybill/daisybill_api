module DaisybillApi
  module Models
    class PaperEor < DaisybillApi::Models::Base
      path_prefix '/remittances', :remittance_id
      rest_actions :index

      attributes id: :integer, readonly: true

      link :remittance, class: 'Remittance'
    end
  end
end
