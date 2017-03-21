require 'spec_helper'

shared_examples_for 'returned error with status' do |status|
  its(:status) { is_expected.to eq status }
  its(:response) { is_expected.to be_a Hash }
  its(:response) { is_expected.to have_key('error') }
end

describe DaisybillApi::Data::Client, :vcr do
  let(:method) { :get }
  let(:params) { {} }
  let(:path) { '/billing_providers/25' }

  subject { DaisybillApi::Data::Client.new(method, path, params) }

  context 'when everything fine' do
    it { is_expected.to be_success }
    its(:response) { is_expected.to be_a Hash }
    its(:response) { is_expected.to have_key('id') }
    its(:response) { is_expected.to have_key('name') }
    its(:response) { is_expected.to have_key('fein') }
  end

  context 'when incorrect API token' do
    before { DaisybillApi.configuration.api_token = 'incorrect token' }

    it_behaves_like 'returned error with status', '401'
  end

  context 'when incorrect url' do
    let(:path) { '/incorrect/url' }

    it_behaves_like 'returned error with status', '401'
  end

  context 'when invalid params' do
    let(:params) { { created_on: 'invalid' } }
    let(:path) { '/invalid/params' }

    it_behaves_like 'returned error with status', '403'
  end

  context 'when record was not found' do
    let(:path) { '/billing_providers/unknown-id' }

    it_behaves_like 'returned error with status', '404'
  end

  context 'when method is not allowed' do
    let(:method) { :post }

    it_behaves_like 'returned error with status', '405'
  end

  context 'when server raised error' do
    let(:path) { '/raised/error' }

    it_behaves_like 'returned error with status', '500'
  end

  context '.build' do
    subject { -> { described_class.build :method, '/path' } }
    let(:status) { 200 }
    let(:message) { '' }

    before do
      client = doubled_client(status, { 'error' => message })
      allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
    end

    it { is_expected.not_to raise_error }

    context 'when bad request' do
      let(:status) { 400 }
      let(:message) { 'invalid record' }

      it { is_expected.not_to raise_error }
    end

    context 'when unauthorized' do
      let(:status) { 401 }
      let(:message) { 'invalid or missed api token' }

      it { is_expected.to raise_error(DaisybillApi::Data::Client::UnauthorizedError).with_message(message) }
    end

    context 'when forbidden' do
      let(:status) { 403 }
      let(:message) { 'invalid params or incorrect url endpoint' }

      it { is_expected.to raise_error(DaisybillApi::Data::Client::InvalidParams).with_message(message) }
    end

    context 'when page not found' do
      let(:status) { 404 }
      let(:response) { { error: 'Record Not Found' } }

      it { is_expected.to_not raise_error }
    end

    context 'when internal server error' do
      let(:status) { 500 }
      let(:message) { 'Internal Server Error' }

      it { is_expected.to raise_error(DaisybillApi::Data::Client::InternalServerError).with_message(message) }
    end
  end
end
