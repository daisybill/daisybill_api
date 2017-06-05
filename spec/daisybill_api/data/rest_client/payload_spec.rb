require "spec_helper"

describe RestClient::Payload do
  subject { RestClient::Payload.generate(params).to_s }

  context "when collection of hashes" do
    let(:params) { { collection: [{ a: 1, b: 2 }, { a: 3, b: 4 }] } }

    it { is_expected.to eq "collection[][a]=1&collection[][b]=2&collection[][a]=3&collection[][b]=4" }
  end

  context "when value is nil" do
    let(:params) { { empty: "", nil: nil, zero: 0 } }

    it { is_expected.to eq "empty=&nil&zero=0" }
  end
end
