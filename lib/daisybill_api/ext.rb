require 'daisybill_api/ext/attributes'
require 'daisybill_api/ext/crud'
require 'daisybill_api/ext/associations'

module DaisybillApi
  module Ext
    class << self
      def extended(base)
        base.class_eval do
          extend  DaisybillApi::Ext::Attributes::ClassMethods
          include DaisybillApi::Ext::Attributes::InstanceMethods
          extend  DaisybillApi::Ext::CRUD::ClassMethods
          include DaisybillApi::Ext::CRUD::InstanceMethods
          extend  DaisybillApi::Ext::Associations::ClassMethods
          include DaisybillApi::Ext::Associations::InstanceMethods
        end
      end
    end
  end
end
