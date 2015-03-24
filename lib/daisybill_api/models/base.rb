require 'active_model'

module DaisybillApi
  module Models
    class Base
      include ActiveModel::Validations
      include ActiveModel::Naming
      extend  DaisybillApi::Ext

      attr_accessor :external_errors

      validate :external

      def initialize(attrs = {})
        self.external_errors = {}
        super
      end

      private

      def external
        return if external_errors.blank?
        external_errors.each { |field, errors|
          errors.each { |error| self.errors.add field, error }
        }
      end
    end
  end
end
