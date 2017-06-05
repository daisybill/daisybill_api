require "spec_helper"

describe DaisybillApi do
  describe "::configure" do
    let(:token) { "api token" }
    let(:host) { nil }
    let(:port) { nil }
    let(:params) { {} }

    before do
      DaisybillApi.configure do |config|
        config.api_token = token
        config.host = host if host
        config.port = port if port
      end
    end

    subject { DaisybillApi::Data::Url.build("/billing_providers").to_s }

    it { is_expected.to eq "https://go.daisybill.com/api/v1/billing_providers?api_token=api+token" }

    context "when host and port changed" do
      let(:host) { "localhost" }
      let(:port) { 3000 }

      it { is_expected.to eq("http://localhost:3000/api/v1/billing_providers?api_token=api+token") }

      context "after reset" do
        before { DaisybillApi.reset_configuration }

        it { is_expected.to eq("https://go.daisybill.com/api/v1/billing_providers?api_token") }
      end
    end
  end
end
