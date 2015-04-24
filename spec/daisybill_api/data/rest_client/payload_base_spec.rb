require 'spec_helper'

describe RestClient::Payload::Base do
  subject { RestClient::Payload.generate(params).to_s }

  context 'when collection of hashes' do
    let(:params) { { collection: [{ a: 1, b: 2 }, { a: 3, b: 4 }] } }

    it { is_expected.to eq 'collection[][a]=1&collection[][b]=2&collection[][a]=3&collection[][b]=4' }
  end
end
