require 'spec_helper'

describe DaisybillApi::Configuration do
  let(:config) { DaisybillApi::Configuration.new }

  context 'default values' do
    it { expect(config.api_token).to be_nil }
    it { expect(config.port).to eq 443 }
    it { expect(config.host).to eq 'go.daisybill.com' }
    it { expect(config.logger).to be_a Logger }
  end
  it "when logger was set to nil" do
    config.logger = nil
    expect(config.logger).to be_a Logger
  end
end
