shared_examples_for DaisybillApi::Ext::CRUD do |*methods, path_or_prefix| #TODO: use **prefix syntax when ruby 1.9.3 wouldn't be supported
  if path_or_prefix.is_a?(Hash)
    property = path_or_prefix.keys.first
    prefix = path_or_prefix.values.last
    path = methods.pop
  else
    prefix = nil
    path = path_or_prefix
  end

  let(:status) { 200 }
  let(:response) { {} }
  let(:attributes) { prefix ? { property => '13666' } : {} }

  before do
    client = doubled_client(status, response)
    allow(DaisybillApi::Data::Client).to receive(:new).and_return(client)
  end

  it { expect(described_class.show_path('its-id')).to eq "#{path}/its-id" }
  if prefix
    it { expect(described_class.index_path('prefix-id')).to eq("#{prefix}/prefix-id#{path}") }
  else
    it { expect(described_class.index_path('id')).to eq path }
  end

  describe 'ClassMethods' do
    subject { described_class }

    it { is_expected.to respond_to :path= }
    it { is_expected.to respond_to :path }
    it { is_expected.to respond_to :path_prefix }
    it { is_expected.to respond_to :path_prefix? }

    describe 'check methods' do
      class_methods = [:all, :find, :create]
      (methods & class_methods).each do |method|
        it { is_expected.to respond_to method }
      end
      (class_methods - methods).each do |method|
        it { is_expected.to_not respond_to method }
      end
    end

    if methods.include? :create
      context '::create' do
        let(:status) { 200 }

        it { expect(described_class.create({})).to be_a described_class }

        context 'when record invalid' do
          let(:status) { 400 }
          let(:response) { { 'errors' => { 'record' => %w(invalid outdated) } } }

          it { expect(described_class.create(attributes)).to be_a described_class }
          it { expect(described_class.create(attributes)).to be_invalid }
          it { expect(described_class.create(attributes).errors[:record]).to have(2).items }
        end

        context 'when internal server error' do
          let(:status) { 500 }
          let(:error) { DaisybillApi::Data::Client::InternalServerError }
          let(:message) { 'Internal Server Error' }
          let(:response) { { 'error' => message } }

          it { expect{described_class.create(attributes)}.to raise_error(error).with_message(message) }
        end

        context 'when unauthorized' do
          let(:status) { 401 }
          let(:error) { DaisybillApi::Data::Client::UnauthorizedError }
          let(:message) { 'Not Authorized' }
          let(:response) { { 'error' => message } }

          it { expect{described_class.create(attributes)}.to raise_error(error).with_message(message) }
        end

        if prefix
          it { expect(subject.create().errors[property]).to have(1).error }
        end
      end
    end

    if methods.include? :find
      context '::find' do
        let(:status) { 200 }

        it { expect(described_class.find('id')).to be_a described_class }

        context 'when record was not found' do
          let(:status) { 404 }
          let(:response) { { error: 'Record Not Found' } }

          it { expect(described_class.find('id')).to be_nil }
        end

        context 'when internal server error' do
          let(:status) { 500 }
          let(:error) { DaisybillApi::Data::Client::InternalServerError }
          let(:message) { 'Internal Server Error' }
          let(:response) { { 'error' => message } }

          it { expect{described_class.find('id')}.to raise_error(error).with_message(message)  }
        end

        context 'when unauthorized' do
          let(:status) { 401 }
          let(:error) { DaisybillApi::Data::Client::UnauthorizedError }
          let(:message) { 'Not Authorized' }
          let(:response) { { 'error' => message } }

          it { expect{described_class.find('id')}.to raise_error(error).with_message(message) }
        end
      end
    end

    if methods.include? :all
      context '::all' do
        let(:status) { 200 }
        let(:response) { { described_class.plural_key => [{}, {}, {}] } }
        let(:params) { property ? { property.to_sym => '13666'} : {} }

        it { expect(described_class.all(params)).to be_a(DaisybillApi::Ext::PageableCollection) }
        it { expect(described_class.all(params)).to have(3).records  }
        it { expect(described_class.all(params)).to all( be_a described_class )  }
        if prefix
          it { expect(described_class.all(params).map(&:"#{property}")).to all( eq 13666 ) }
        end
      end
    end
  end

  describe 'InstanceMethods' do
    describe 'check methods' do
      let(:status) { 200 }

      before { subject.attributes = attributes } if prefix

      instance_methods = [:create, :update, :destroy]
      (methods & instance_methods).each do |method|
        its(method) { is_expected.to be_truthy }
      end

      (instance_methods - methods).each do |method|
        it { is_expected.to_not respond_to method }
      end

      if (methods & [:create, :update]).empty?
        it { is_expected.to_not respond_to :save }
      else
        its(:save) { is_expected.to be_truthy }
      end
    end

    it { is_expected.to be_new_record }
    it { is_expected.to_not be_destroyed }

    if methods.include? :update
      context '.update' do
        before { subject.id = 13666 }

        context 'when record invalid' do
          let(:status) { 400 }
          let(:response) { { 'errors' => { 'record' => %w(invalid outdated) } } }

          before { subject.update }

          it { is_expected.to be_invalid }
          it { expect(subject.errors[:record]).to have(2).items }
        end

        context 'when was set external errors' do
          let(:status) { 200 }
          let(:response) { {} }

          before { subject.external_errors = { record: ['invalid'] } }

          its(:update) { is_expected.to be_truthy }
        end

        if prefix
          it 'when prefix property was not set' do
            subject.update
            expect(subject.errors[property]).to be_empty
          end
        end
      end
    end

    if methods.include? :destroy
      context '.destroy' do
        before { subject.id = 13666 }

        context 'when record invalid' do
          let(:status) { 400 }
          let(:response) { { 'errors' => { 'record' => ['can not be destroyed'] } } }

          before { subject.destroy }

          it { is_expected.to be_invalid }
          it { expect(subject.errors[:record]).to have(1).item }
        end
      end
    end
  end
end
