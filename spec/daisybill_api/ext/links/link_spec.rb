require "spec_helper"

describe DaisybillApi::Ext::Links::Link do
  subject { described_class.new :rendering_provider, "DaisybillApi::Models::RenderingProvider" }

  let(:status) { 200 }
  let(:response) { {} }

  before do
    subject.href = "/api/v1/some/url/:id"
    client = doubled_client status, response
    allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
  end

  its(:value) { is_expected.to be_a DaisybillApi::Models::RenderingProvider }
  its(:foreign_id) { is_expected.to eq(":id") }

  it "when href is nil" do
    subject.href = nil
    expect(subject.value).to be_nil
  end

  it "must send data to correct url" do
    expect(DaisybillApi::Data::Client).to receive(:new).with(:get, "/some/url/:id", {})
    subject.value
  end

  context "when link was not found" do
    let(:status) { 404 }
    let(:response) { { "error" => "Record Not Found" } }

    its(:value) { is_expected.to be nil }
  end

  context "when was server error" do
    let(:status) { 500 }
    let(:message) { "Internal Server Error" }
    let(:response) { { "error" => message } }

    it { expect{ subject.value }.to raise_error(DaisybillApi::Data::Client::InternalServerError).with_message(message) }
  end

  context "when was server error" do
    let(:status) { 401 }
    let(:message) { "Not Authorized" }
    let(:response) { { "error" => message } }

    it { expect{ subject.value }.to raise_error(DaisybillApi::Data::Client::UnauthorizedError).with_message(message) }
  end
end
