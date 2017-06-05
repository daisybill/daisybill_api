require "spec_helper"

describe DaisybillApi::Ext::PageableCollection do
  let(:resource_class) { DaisybillApi::Models::Bill }
  let(:page) { described_class.new(entries, options) }
  let(:entries) { 2.times.map { resource_class.new } }
  let(:options) { { resource_class: resource_class, params: params, headers: headers } }
  let(:headers) { {} }
  let(:params)  { {} }
  let(:another_page) { described_class.new(entries, another_page_options) }
  let(:another_page_headers) { {} }
  let(:another_page_options) { { resource_class: resource_class, params: params, headers: another_page_headers } }

  before do
    allow(DaisybillApi::Models::Bill).to receive(:all) { another_page }
  end

  describe "enumerable" do
    subject { page }

    it { is_expected.to respond_to(:each) }
    it { expect(described_class.included_modules).to include(Enumerable) }
  end

  describe "#first_page" do
    subject { page.first_page }

    let(:headers) { {
      x_prev_page: "2",
      x_next_page: "4",
      x_page: "3"
    } }

    let(:another_page_headers) { {
      x_prev_page: "",
      x_next_page: "2",
      x_page: "1"
    } }

    it { is_expected.to be_a(described_class) }
    it { expect(subject.previous_page).to be_nil }
    it { expect(subject.current_page_number).to eq(1) }
  end

  describe "#last_page" do
    subject { page.last_page }

    let(:headers) { {
      total_page_count: "3",
      x_next_page: "2",
      x_page: "1"
    } }

    let(:another_page_headers) { {
      x_prev_page: "2",
      x_next_page: "",
      x_page: "3"
    } }

    it { is_expected.to be_a(described_class) }
    it { expect(subject.current_page_number).to eq(3) }
    it { expect(subject.next_page).to be_nil }
  end

  describe "#next_page" do
    subject { page.next_page }

    context "when there is a next page" do
      let(:headers) { {
        total_page_count: "3",
        x_next_page: "2",
        x_page: "1"
      } }

      let(:another_page_headers) { {
        x_prev_page: "2",
        x_next_page: "",
        x_page: "3"
      } }

      it { is_expected.to be_a(described_class) }
      it { expect(subject.current_page_number).to eq(3) }
      it { expect(subject.next_page).to be_nil }
    end

    context "when next page is nil" do
      let(:headers) { {
        total_page_count: "3",
        x_next_page: "",
        x_page: "3"
      } }

      it { is_expected.to be_nil }
    end
  end

  describe "#previous_page" do
    subject { page.previous_page }

    context "when there is a previous page" do
      let(:headers) { {
        total_page_count: "3",
        x_next_page: "3",
        x_prev_page: "1",
        x_page: "2"
      } }

      let(:another_page_headers) { {
        total_page_count: "3",
        x_prev_page: "",
        x_next_page: "2",
        x_page: "1"
      } }

      it { is_expected.to be_a(described_class) }
      it { expect(subject.current_page_number).to eq(1) }
      it { expect(subject.previous_page).to be_nil }
    end

    context "when previous page is nil" do
      let(:headers) { {
        x_next_page: "2",
        x_prev_page: "",
        x_page: "1"
      } }

      it { is_expected.to be_nil }
    end
  end
  describe "#current_page_number" do
    subject { page.current_page_number }

    context "when x page is set in headers" do
      let(:headers) { { x_page: "2" } }

      it { expect(subject).to eq(2) }
    end

    context "when x page is not set in headers" do
      let(:headers) { { x_page: "" } }

      it { expect(subject).to be_nil }
    end
  end
end
