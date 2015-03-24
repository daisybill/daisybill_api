require 'rspec'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'daisybill_api'
require 'vcr'
require 'ffaker'

Dir["#{DaisybillApi::ROOT}/spec/support/**/*.rb"].each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = "#{DaisybillApi::ROOT}/spec/fixtures/vcr"
  config.hook_into :webmock
  config.default_cassette_options = { :record => :new_episodes }
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.before { DaisybillApi.reset_configuration }
end

def doubled_client(status, response)
  statuses = {
    success?: status == 200,
    bad_request?: status == 400,
    unauthorized?: status == 401,
    not_found?: status == 404,
    error?: status == 500,
    response: response
  }

  double(DaisybillApi::Data::Client, statuses)
end
