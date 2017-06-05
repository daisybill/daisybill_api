module DaisybillApi
  module Ext
    module Attributes
      module SendAs
      end
    end
  end
end

shared_examples_for DaisybillApi::Ext::Attributes do |*attributes|
  let(:attributes_hash) { generate_attributes attributes, described_class }
  subject { described_class.new attributes_hash }

  it { expect{ described_class.new( unknown_attribute: "any value") }.to_not raise_error }

  it "should not have extra attributes" do
    if attributes.last.is_a?(Hash)
      attrs = attributes.last.keys.map(&:to_s) + attributes[0..-2].map(&:to_s)
    else
      attrs = attributes.map(&:to_s)
    end
    expect(subject.attributes.keys - attrs.uniq).to be_empty
  end

  attributes.each do |name|
    if name.is_a? Hash
      name.each { |attr, type|
        its(:attributes) { is_expected.to include attr.to_s  }
        it { is_expected.to respond_to attr }
        it { is_expected.to respond_to :"#{attr}=" }
        if type == :model
          its(attr) { is_expected.to respond_to :attributes }
        else
          its(attr) { is_expected.to be_a Array }
        end
      }
    else
      its(:attributes) { is_expected.to include name.to_s  }
      it { is_expected.to respond_to name }
      it { is_expected.to respond_to :"#{name}=" }
      its(name) { is_expected.to eq attributes_hash[name] }
    end
  end
end

shared_examples_for DaisybillApi::Ext::Attributes::SendAs do |*attributes|
  subject { described_class.new(attributes_hash).to_params }

  let(:attributes_hash) { {} } #generate_attributes attributes, described_class }

  it { is_expected.to have(attributes.size).items }

  attributes.each do |attribute|
    it { is_expected.to include attribute.to_s }
  end
end
