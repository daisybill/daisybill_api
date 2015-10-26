require 'logger'

module DaisybillApi
  class Configuration

    # Sets and gets the API Token
    #
    #   DaisybillApi.configuration.api_token                     # => "987654321zyxwvu"
    #   DaisybillApi.configuration.api_token = "123456789abcdef" # => "123456789abcdef"
    #   DaisybillApi.configuration.api_token                     # => "123456789abcdef"'
    #
    # @return [String]
    attr_accessor :api_token

    # Sets and gets the host
    #
    #   DaisybillApi.configuration.host               # => "go.daisybill.com"
    #   DaisybillApi.configuration.host = "localhost" # => "localhost"
    #   DaisybillApi.configuration.host               # => "localhost"
    #
    # @return [String]
    attr_accessor :host

    # Sets and gets the port
    #
    #   DaisybillApi.configuration.port        # => 443
    #   DaisybillApi.configuration.port = 3000 # => 3000
    #   DaisybillApi.configuration.port        # => 3000
    #
    # @return [Integer]
    attr_accessor :port

    # @private
    attr_writer :logger

    def initialize
      @port = 443
      @host = 'go.daisybill.com'
    end

    # @private
    def logger
      @logger ||= Logger.new nil
    end
  end
end
