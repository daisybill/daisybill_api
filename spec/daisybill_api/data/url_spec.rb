require 'spec_helper'

describe DaisybillApi::Data::Url do
  before { DaisybillApi.configure { |c| c.api_token = 'token' } }
  let(:path) { 'billing_providers' }
  let(:params) { { page: 1, per_page: 20 } }

  subject { DaisybillApi::Data::Url.build(path, params).to_s }

  it { is_expected.to include 'page=1' }
  it { is_expected.to include 'per_page=20' }
  it { is_expected.to include 'api_token=token' }
end
