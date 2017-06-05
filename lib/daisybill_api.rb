require "daisybill_api/data"
require "daisybill_api/configuration"
require "daisybill_api/ext"
require "daisybill_api/models"

module DaisybillApi
  # @private
  ROOT = File.expand_path("../..", __FILE__)

  class << self
    attr_writer :configuration


    # Returns the current configuration
    #
    #   DaisybillApi.configuration
    #   # => #<DaisybillApi::Configuration:0x007fbf85e64e88 @host="go.daisybill.com", @port=443>
    #
    # @return [DaisybillApi::Configuration]
    def configuration
      @configuration ||= DaisybillApi::Configuration.new
    end

    # Allows configuration with a block
    #
    #   DaisybillApi.configure do |config|
    #     config.host = "localhost"
    #     config.port = 3000
    #     config.api_token = "123abc"
    #   end
    def configure
      yield configuration
    end

    # Resets the configuration
    #
    #   DaisybillApi.configuration.host = "localhost" # => "localhost"
    #   DaisybillApi.configuration.port = 3000        # => 3000
    #
    #   DaisybillApi.reset_configuration              # => nil
    #   DaisybillApi.configuration.host               # => "go.daisybill.com"
    #
    # @return [nil]
    def reset_configuration
      @configuration = nil
    end

    # @private
    def logger
      configuration.logger
    end
  end
end
