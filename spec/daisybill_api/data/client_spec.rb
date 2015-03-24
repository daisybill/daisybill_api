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

  context 'when record was not found' do
    let(:path) { '/billing_providers/unknown-id' }

    it_behaves_like 'returned error with status', '404'
  end

  context 'when server raised error' do
    let(:path) { '/raised/error' }

    it_behaves_like 'returned error with status', '500'
  end
end
