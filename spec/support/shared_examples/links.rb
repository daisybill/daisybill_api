shared_examples_for DaisybillApi::Ext::Links do |links = {}|
  context 'ClassMethods' do
    subject { described_class }

    it { is_expected.to respond_to :link }
  end

  context 'InstanceMethods' do
    let(:client) { doubled_client(200, {}) }
    before do
      allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
      subject.links = collection
    end

    context 'when links are nil' do
      let(:collection) { nil }

      links.each_key do |name|
        its(name) { is_expected.to be_nil }
      end
    end

    context 'when links are empty array' do
      let(:collection) { [] }

      links.each_key do |name|
        its(name) { is_expected.to be_nil }
      end
    end

    context 'when links are passed' do
      let(:collection) { links.map { |name, _| { 'rel' => name.to_s, 'href' => '/some/url' } } }

      links.each do |name, type|
        its(name) { is_expected.to be_a type }
      end
    end

    context 'when come un existing link' do
      let(:collection) { [{ 'rel' => 'not_existed_link', 'href' => '/some/url' }] }

      it { is_expected.to be }
    end
  end
end
