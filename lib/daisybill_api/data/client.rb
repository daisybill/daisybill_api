require "rest-client"

module DaisybillApi
  # @private
  module Data
    class Client
      class BasicError < StandardError; end
      class InternalServerError < BasicError; end
      class UnauthorizedError < BasicError; end
      class InvalidParams < BasicError; end
      class MethodNotAllowed < BasicError; end

      def self.build(method, path, params = {})
        client = new method, path, params
        raise InternalServerError.new(client.response["error"]) if client.error?
        raise UnauthorizedError.new(client.response["error"]) if client.unauthorized?
        raise InvalidParams.new(client.response["error"]) if client.forbidden?
        raise MethodNotAllowed.new(client.response["error"]) if client.method_not_allowed?
        client
      end

      attr_reader :response, :request, :headers

      def initialize(method, path, params = {})
        DaisybillApi.logger.info "#{method.to_s.upcase} #{path}"
        DaisybillApi.logger.debug params.inspect
        url = DaisybillApi::Data::Url.build(path).to_s
        data = {
          method: method,
          url: url,
          payload: params.to_json,
          headers: { "Content-Type" => "application/json" }
        }
        RestClient::Request.execute(data) { |response, request, status|
          @headers = response.headers
          @response = JSON.parse response
          @request = request
          @status = status
          DaisybillApi.logger.info "Response status #{self.status}"
          DaisybillApi.logger.debug @response.inspect
        }
      end

      def status
        @status.code
      end

      def success?
        status == "200" || status == "201"
      end

      def bad_request?
        status == "400"
      end

      def unauthorized?
        status == "401"
      end

      def not_found?
        status == "404"
      end

      def forbidden?
        status == "403"
      end

      def method_not_allowed?
        status == "405"
      end

      def error?
        status == "500"
      end
    end
  end
end
