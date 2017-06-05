require "uri/http"

module DaisybillApi
  module Data
    module Url
      DEFAULT_PATH = "/api/v1"

      class << self
        def build(path, params = {})
          port = DaisybillApi.configuration.port
          builder = port == 443 ? URI::HTTPS : URI::HTTP
          builder.build({
              host: DaisybillApi.configuration.host,
              port: port,
              path: "#{DEFAULT_PATH}#{path}",
              query: to_query(params.merge api_token: DaisybillApi.configuration.api_token)
            })
        end

        def to_query(hash)
          URI.encode_www_form hash
        end
      end
    end
  end
end
