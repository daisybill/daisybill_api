require 'daisybill_api/data'
require 'daisybill_api/configuration'
require 'daisybill_api/ext'
require 'daisybill_api/models'

module DaisybillApi
  ROOT = File.expand_path('../..', __FILE__)

  class << self
    attr_writer :configuration


    def configuration
      @configuration ||= DaisybillApi::Configuration.new
    end

    def configure
      yield configuration
    end

    def reset_configuration
      @configuration = nil
    end

    def logger
      configuration.logger
    end
  end
end
