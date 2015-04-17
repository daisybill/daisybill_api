require 'spec_helper'

describe DaisybillApi::Ext::Links::Link do
  subject { described_class.new :rendering_provider, 'DaisybillApi::Models::RenderingProvider' }

  let(:status) { 200 }
  let(:response) { {} }
  let(:model) { DaisybillApi::Models::Bill.new }

  before do
    subject.object = model
    subject.href = '/api/v1/some/url/13666'
    client = doubled_client status, response
    allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
  end

  it { expect(model.rendering_provider_id).to eq 13666 }
  its(:value) { is_expected.to be_a DaisybillApi::Models::RenderingProvider }

  it 'when href is nil' do
    subject.href = nil
    expect(subject.value).to be_nil
  end

  it 'must send data to correct url' do
    expect(DaisybillApi::Data::Client).to receive(:new).with(:get, '/some/url/13666', {})
    subject.value
  end

  context 'when link was not found' do
    let(:status) { 404 }
    let(:response) { { 'error' => 'Record Not Found' } }

    its(:value) { is_expected.to be nil }
  end

  context 'when was server error' do
    let(:status) { 500 }
    let(:message) { 'Internal Server Error' }
    let(:response) { { 'error' => message } }

    it { expect{ subject.value }.to raise_error(DaisybillApi::Data::Client::InternalServerError).with_message(message) }
  end

  context 'when was server error' do
    let(:status) { 401 }
    let(:message) { 'Not Authorized' }
    let(:response) { { 'error' => message } }

    it { expect{ subject.value }.to raise_error(DaisybillApi::Data::Client::UnauthorizedError).with_message(message) }
  end
end
