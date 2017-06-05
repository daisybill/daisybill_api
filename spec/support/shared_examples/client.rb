shared_examples_for "used client that raise exceptions" do
  let(:status) { 200 }

  before do
    client = doubled_client(status, response)
    allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
  end

  context "when success" do
    let(:status) { 200 }
    let(:response) { {} }

    it { is_expected.to_not raise_error }
  end

  context "when success" do
    let(:status) { 400 }
    let(:response) { { "error" => "Occurs on record invalid" } }

    it { is_expected.to_not raise_error }
  end

  context "when unauthorized" do
    let(:status) { 401 }
    let(:message) { "Not Authorized" }
    let(:response) { { "error" => message } }

    it { is_expected.to raise_error(DaisybillApi::Data::Client::UnauthorizedError).with_message(message) }
  end

  context "when page not found" do
    let(:status) { 404 }
    let(:response) { { error: "Record Not Found" } }

    it { is_expected.to_not raise_error }
  end

  context "when method not allowed" do
    let(:status) { 405 }
    let(:response) { { error: "Method not allowed" } }

    it { is_expected.to raise_error(DaisybillApi::Data::Client::MethodNotAllowed) }
  end

  context "when internal server error" do
    let(:status) { 500 }
    let(:message) { "Internal Server Error" }
    let(:response) { { "error" => message } }

    it { is_expected.to raise_error(DaisybillApi::Data::Client::InternalServerError).with_message(message) }
  end
end
