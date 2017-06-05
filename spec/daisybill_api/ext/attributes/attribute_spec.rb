require "spec_helper"

describe DaisybillApi::Ext::Attributes::Attribute do
  let(:name) { "description" }
  let(:type) { :string }
  let(:options) { {} }
  subject { described_class.new name, type, options }

  it "#value=" do
    expect(DaisybillApi::Ext::Attributes::TypeCastings).to receive(:convert_to).with("value", :string)
    subject.value = "value"
  end

  context "value" do
    let(:type) { [:integer] }

    its(:value) { is_expected.to eq [] }
  end

  context "#param_name" do
    subject { super().param_name }

    it { is_expected.to eq "description" }

    context "when type is model" do
      let(:type) { DaisybillApi::Models::Address }

      it { is_expected.to eq "description_attributes" }
    end

    context "when type is a simple collection" do
      let(:type) { [:integer] }

      it { is_expected.to eq "description" }
    end

    context "when type is a collection of models" do
      let(:type) { [DaisybillApi::Models::Address] }

      it { is_expected.to eq "description_attributes" }
    end
  end

  context "#param_value" do
    let(:value) { "value" }
    before { subject.value = value }

    it { expect(subject.param_value).to eq "value" }

    context "when type is model" do
      let(:type) { DaisybillApi::Models::Address }
      let(:attrs) { { "address_1" => "addr1", "address_2" => nil, "city" => "NY", "state" => "NY", "zip_code" => "123"} }
      let(:value) { type.new attrs }

      its(:param_value) { is_expected.to eq attrs }
    end

    context "when type is collection" do
      let(:type) { [:integer] }
      let(:value) { %w(13 666) }

      its(:param_value) { is_expected.to eq [13, 666] }
    end

    context "when type is collection of models" do
      let(:type) { [DaisybillApi::Models::Address] }
      let(:attrs1) { { "address_1" => "addr1", "address_2" => "addr2", "city" => "City", "state" => "st", "zip_code" => "123" } }
      let(:attrs2) { { "address_1" => "addr3", "address_2" => "addr4", "city" => "city", "state" => "St", "zip_code" => "456" } }
      let(:value) do
        [
          DaisybillApi::Models::Address.new(attrs1),
          DaisybillApi::Models::Address.new(attrs2)
        ]
      end

      it { expect(subject.param_value).to eq [attrs1, attrs2] }
    end
  end

  context "#to_param" do
    context "when not readonly" do
      before { allow(subject).to receive(:readonly?).and_return(false) }
      it "must call param_name method" do
        expect(subject).to receive(:param_name)
        subject.to_param
      end

      it "must call param_name method" do
        expect(subject).to receive(:param_value)
        subject.to_param
      end
    end

    context "when readonly" do
      before { allow(subject).to receive(:readonly?).and_return(true) }

      it "must not call param_name method" do
        expect(subject).to_not receive(:param_name)
        subject.to_param
      end

      it "must not call param_name method" do
        expect(subject).to_not receive(:param_value)
        subject.to_param
      end
    end
  end

  context "#readonly?" do
    subject { super().readonly? }

    it { is_expected.to be_falsey }

    context "when readonly passed" do
      let(:options) { { readonly: true } }

      it { is_expected.to be_truthy }
    end
  end
end
