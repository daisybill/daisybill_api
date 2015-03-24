require 'logger'

module DaisybillApi
  class Configuration
    attr_accessor :api_token, :host, :port

    attr_writer :logger

    def initialize
      @port = 443
      @host = 'go.daisybill.com'
    end

    def logger
      @logger ||= Logger.new nil
    end
  end
end
