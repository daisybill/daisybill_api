require "spec_helper"
require "webmock/rspec"

describe DaisybillApi::Data::Client, "GET request params handling" do
  before do
    DaisybillApi.configure do |config|
      config.api_token = "test-token"
      config.host = "go.daisybill.com"
      config.port = 443
    end
  end

  let(:response_body) { { "payers" => [{ "id" => 1, "name" => "Test Payer" }] }.to_json }

  describe "GET requests" do
    it "does not include a request body" do
      stub = stub_request(:get, %r{go.daisybill.com/api/v1/claims_administrators/2985/payers})
        .with { |request| request.body.nil? || request.body.empty? }
        .to_return(status: 200, body: response_body, headers: { "Content-Type" => "application/json" })

      DaisybillApi::Data::Client.new(:get, "/claims_administrators/2985/payers", { claims_administrator_id: 2985 })

      expect(stub).to have_been_requested
    end

    it "sends params as query string parameters" do
      stub = stub_request(:get, %r{go.daisybill.com/api/v1/claims_administrators/2985/payers})
        .with(query: hash_including("claims_administrator_id" => "2985"))
        .to_return(status: 200, body: response_body, headers: { "Content-Type" => "application/json" })

      DaisybillApi::Data::Client.new(:get, "/claims_administrators/2985/payers", { claims_administrator_id: 2985 })

      expect(stub).to have_been_requested
    end
  end

  describe "POST requests" do
    let(:post_response_body) { { "id" => 1, "name" => "Test" }.to_json }

    it "sends params as a request body" do
      stub = stub_request(:post, %r{go.daisybill.com/api/v1/patients})
        .with { |request| !request.body.nil? && !request.body.empty? }
        .to_return(status: 201, body: post_response_body, headers: { "Content-Type" => "application/json" })

      params = { patient: { first_name: "John", last_name: "Smith" } }
      DaisybillApi::Data::Client.new(:post, "/patients", params)

      expect(stub).to have_been_requested
    end
  end
end
