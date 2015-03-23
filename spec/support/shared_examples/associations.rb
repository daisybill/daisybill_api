module DaisybillApi
  module Ext
    module Associations
      module HasMany
      end

      module BelongsTo
      end
    end
  end
end

shared_examples_for DaisybillApi::Ext::Associations do
  subject { described_class }

  it { is_expected.to respond_to :has_many }
  it { is_expected.to respond_to :belongs_to }
end

shared_examples_for DaisybillApi::Ext::Associations::HasMany do |has_many|
  it { expect(described_class.index_path).to eq "/#{described_class.plural_key}" }
  it { is_expected.to respond_to has_many.plural_key }
end

shared_examples_for DaisybillApi::Ext::Associations::BelongsTo do |belongs_to|
  context 'ClassMethods' do
    subject { described_class }

    its(:foreign_key) { is_expected.to be }
    it { is_expected.to respond_to(:all).with(1).argument }
    it { expect(subject.index_path(':id:')).to eq "/#{belongs_to.plural_key}/:id:/#{subject.plural_key}" }
    it { expect(subject.create({}).errors[subject.foreign_key]).to have(1).item }
  end

  context 'InstanceMethods' do
    it { is_expected.to respond_to belongs_to.singular_key }
    it 'must send data to correct url' do
      allow(subject).to receive(:valid?).and_return(true)
      subject.send(:"#{described_class.foreign_key}=", 13666)
      expected_path = "/#{belongs_to.plural_key}/13666/#{described_class.plural_key}"
      c = doubled_client(200, {})
      expect(DaisybillApi::Data::Client).to receive(:new).with(:post, expected_path, anything).and_return(c)
      subject.create
    end
    it "##{belongs_to.singular_key}" do
      allow(DaisybillApi::Data::Client).to receive(:new).and_return(doubled_client 200, {})
      expect(subject.send belongs_to.singular_key).to be_a belongs_to
    end
  end
end
