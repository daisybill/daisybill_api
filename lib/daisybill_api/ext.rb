require 'daisybill_api/ext/attributes'
require 'daisybill_api/ext/crud'
require 'daisybill_api/ext/associations'

module DaisybillApi
  module Ext
    class << self
      def extended(base)
        base.class_eval do
          include DaisybillApi::Ext::Attributes
          include DaisybillApi::Ext::CRUD
          include  DaisybillApi::Ext::Associations
        end
      end
    end
  end
end
