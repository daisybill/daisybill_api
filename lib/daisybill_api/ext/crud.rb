require "daisybill_api/ext/crud/index"
require "daisybill_api/ext/crud/create"
require "daisybill_api/ext/crud/show"
require "daisybill_api/ext/crud/update"
require "daisybill_api/ext/crud/destroy"
require "daisybill_api/ext/crud/search"
require "daisybill_api/ext/crud/write_off"

module DaisybillApi
  module Ext
    module CRUD
      # @private
      module ClassMethods
        def rest_actions(*actions)
          actions.each { |action|
            name = action.to_s.classify
            extend "DaisybillApi::Ext::CRUD::#{name}::ClassMethods".constantize
            include "DaisybillApi::Ext::CRUD::#{name}::InstanceMethods".constantize
          }
        end

        def path=(value)
          @path = value
        end

        def path
          @path ||= "/#{plural_key}"
        end

        def path_prefix(path, property)
          @prefix_path = path
          @prefix_property = property
          attribute property, :integer, readonly: true
          validates property, presence: true, if: :new_record?
        end

        def path_prefix?
          !!(@prefix_path && @prefix_property)
        end

        def prefix_path
          @prefix_path
        end

        def prefix_property
          @prefix_property
        end

        def plural_key
          @plural_key ||= demodulize self.model_name.plural
        end

        def singular_key
          @singular_key ||= demodulize self.model_name.singular
        end

        def show_path(id)
          "#{path}/#{id}"
        end

        def index_path(prefix_id)
          if path_prefix?
            index_path_with_prefix(prefix_id)
          else
            index_path_without_prefix
          end
        end

        def search_path(prefix_id)
          "#{index_path(prefix_id)}/search"
        end

        def client(method, path, params = {})
          DaisybillApi::Data::Client.build method, path, params
        end

        private

        PREFIX_LENGTH = "daisybill_api_models_".length

        def demodulize(name)
          name[PREFIX_LENGTH..name.length]
        end

        def index_path_with_prefix(prefix_id)
          "#{prefix_path}/#{prefix_id}#{path}"
        end

        def index_path_without_prefix
          path
        end
      end

      # @private
      module InstanceMethods
        def new_record?
          id.nil?
        end

        def destroyed?
          !!@destroyed
        end

        protected

        def index_path
          params = self.class.path_prefix? ? [self.send(self.class.prefix_property)] : []
          self.class.index_path(*params)
        end

        def show_path
          self.class.show_path(id)
        end

        def data
          { self.class.singular_key => to_params }
        end

        private

        def client(method, path, params = {})
          self.class.client method, path, params
        end

        def send_data(method, url)
          self.external_errors = nil
          valid? && process_response(client method, url, data)
        end

        def process_response(client)
          if client.success?
            response = client.response.clone
            self.links = response.delete "links"
            self.attributes = response
            true
          elsif client.bad_request?
            self.external_errors = client.response["errors"]
            self.valid?
          else
            false
          end
        end
      end

      def self.included(base)
        base.class_eval do
          include DaisybillApi::Ext::CRUD::InstanceMethods
          extend DaisybillApi::Ext::CRUD::ClassMethods
        end
      end
    end
  end
end
