shared_examples_for DaisybillApi::Ext::Attributes do |*attributes|
  let(:attributes_hash) do
    generate_attributes attributes, described_class
  end
  subject { described_class.new attributes_hash }

  describe '#to_params' do
    subject { super().to_params }

    described_class.attrs.each { |name, type|
      if type.is_a? Class
        its(["#{name}_attributes"]) { is_expected.to be_a Hash }
      else
        it { is_expected.to include name }
      end
    }
  end

  it { expect{ described_class.new( unknown_attribute: 'any value') }.to_not raise_error }
  attributes.each do |name|
    if name.is_a? Hash
      name.each { |attr, attrs|
        its(:attributes) { is_expected.to include attr.to_s  }
        it { is_expected.to respond_to attr }
        it { is_expected.to respond_to :"#{attr}=" }
        its(attr) { is_expected.to respond_to :attributes }
        attrs.each do |n|
          its(attr) { is_expected.to respond_to n }
          its(attr) { is_expected.to respond_to :"#{n}=" }
          its("#{attr}.#{n}") { is_expected.to eq attributes_hash[attr][n] }
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
