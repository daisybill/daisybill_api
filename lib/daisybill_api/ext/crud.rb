module DaisybillApi
  module Ext
    module CRUD
      module ClassMethods
        def path=(value)
          @path = value
        end

        def path
          @path ||= "/#{plural_key}"
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

        def index_path
          path
        end

        def create(attributes = {})
          instance = new(attributes)
          instance.create
          instance
        end

        def find(id)
          c = client :get, show_path(id)
          new(c.response) if c.success?
        end

        def all
          c = client :get, index_path
          process_collection c
        end

        def client(method, path, params = {})
          client = DaisybillApi::Data::Client.new method, path, params
          raise DaisybillApi::Data::Client::InternalServerError.new(client.response['error']) if client.error?
          raise DaisybillApi::Data::Client::UnauthorizedError.new(client.response['error']) if client.unauthorized?
          client
        end

        protected

        def process_collection(client)
          return [] unless client.success?
          client.response[plural_key.to_s].map { |attributes|
            new(attributes)
          }
        end

        private

        PREFIX_LENGTH = 21

        def demodulize(name)
          name[PREFIX_LENGTH..name.length]
        end
     end

      module InstanceMethods
        def save
          new_record? ? create : update
        end

        def create
          send_data :post, index_path
        end

        def update
          send_data :patch, show_path
        end

        def destroy
          c = self.class.client :delete, show_path
          @destroyed = c.success?
        end

        def new_record?
          id.nil?
        end

        def destroyed?
          @destroyed || false
        end

        protected

        def index_path
          self.class.index_path
        end

        def show_path
          self.class.show_path(id)
        end

        def data
          { self.class.singular_key => to_params }
        end

        private

        def send_data(method, url)
          self.external_errors = nil
          valid? && process_response(self.class.client method, url, data)
        end

        def process_response(client)
          if client.success?
            self.attributes = client.response
            true
          elsif client.bad_request?
            self.external_errors = client.response['errors']
            self.valid?
          else
            false
          end
        end
      end

      def self.included(base)
        base.include DaisybillApi::Ext::CRUD::InstanceMethods
        base.extend DaisybillApi::Ext::CRUD::ClassMethods
      end
    end
  end
end
