shared_examples_for DaisybillApi::Ext::CRUD do |path, *params|
  let(:status) { 200 }
  let(:response) { {} }

  before do
    client = doubled_client(status, response)
    allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
    allow(described_class).to receive(:index_path).and_return('/')
    if fk = described_class.foreign_key
      allow_any_instance_of(described_class).to receive(fk).and_return('foreign-key')
    end
  end

  it { expect(described_class.show_path('its-id')).to eq "#{path}/its-id" }

  describe 'ClassMethods' do
    context 'when everything fine' do
      let(:status) { 200 }

      it { expect(described_class.find('id')).to be_a described_class }
      it { expect(described_class.create({})).to be_a described_class }

      context '::all' do
        let(:response) { { described_class.plural_key => [{}, {}, {}] } }

        it { expect(described_class.all(*params)).to have(3).records  }
        it { expect(described_class.all(*params)).to all( be_a described_class )  }
      end
    end

    context 'when record was not found' do
      let(:status) { 404 }
      let(:response) { { error: 'Record Not Found' } }

      it { expect(described_class.find('id')).to be_nil }
    end

    context 'when record invalid' do
      let(:status) { 400 }
      let(:response) { { 'errors' => { 'record' => %w(invalid outdated) } } }

      it { expect(described_class.create({})).to be_a described_class }
      it { expect(described_class.create({})).to be_invalid }
      it { expect(described_class.create({}).errors[:record]).to have(2).items }
    end

    context 'when internal server error' do
      let(:status) { 500 }
      let(:error) { DaisybillApi::Data::Client::InternalServerError }
      let(:message) { 'Internal Server Error' }
      let(:response) { { 'error' => message } }

      it { expect{described_class.find('id')}.to raise_error(error).with_message(message)  }
      it { expect{described_class.create({})}.to raise_error(error).with_message(message) }
    end

    context 'when unauthorized' do
      let(:status) { 401 }
      let(:error) { DaisybillApi::Data::Client::UnauthorizedError }
      let(:message) { 'Not Authorized' }
      let(:response) { { 'error' => message } }

      it { expect{described_class.find('id')}.to raise_error(error).with_message(message) }
      it { expect{described_class.create({})}.to raise_error(error).with_message(message) }
    end
  end

  describe 'InstanceMethods' do
    it { is_expected.to respond_to :save }
    it { is_expected.to respond_to :create }
    it { is_expected.to respond_to :update }
    it { is_expected.to respond_to :destroy }
    it { is_expected.to be_new_record }
    it { is_expected.to_not be_destroyed }

    context 'when everything fine' do
      let(:status) { 200 }

      its(:save) { is_expected.to be_truthy }
      its(:create) { is_expected.to be_truthy }
      its(:update) { is_expected.to be_truthy }
      its(:destroy) { is_expected.to be_truthy }
      its(:destroy) { is_expected.to be_truthy }
    end

    context 'when record invalid' do
      let(:status) { 400 }
      let(:response) { { 'errors' => { 'record' => %w(invalid outdated) } } }
      
      before do
        subject.id = 'id'
        subject.update
      end

      it { is_expected.to be_invalid }
      it { expect(subject.errors[:record]).to have(2).items }
    end

    context 'when was set external errors' do
      let(:status) { 200 }
      let(:response) { {} }

      before do
        subject.id = 'id'
        subject.external_errors = { record: ['invalid'] }
      end

      its(:update) { is_expected.to be_truthy }
    end
  end
end
