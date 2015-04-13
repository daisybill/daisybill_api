require 'spec_helper'

describe DaisybillApi::Ext::Attributes::TypeCastings do
  let(:converter) { described_class }

  it { expect(converter.convert_to('2015-03-13', :date)).to eq Date.new(2015, 3, 13) }
  it { expect(converter.convert_to(DateTime.new(2015, 3, 3, 12, 27, 13), :date)).to eq Date.new(2015, 3, 3) }
  it { expect(converter.convert_to('not a date', :date)).to be_nil }
  it { expect(converter.convert_to('', :date)).to be_nil }
  it 'casting of date time' do
    casted = converter.convert_to('2015-03-13T12:27:13.666-08:00', :datetime)
    expect(casted).to eq DateTime.new(2015, 3, 13, 12, 27, 13.666, '-8')
  end
  it { expect(converter.convert_to(Date.new(2015, 3, 13), :datetime)).to eq DateTime.new(2015, 3, 13) }
  it { expect(converter.convert_to('not a datetime', :datetime)).to be_nil }
  it { expect(converter.convert_to('', :datetime)).to be_nil }
  it { expect(converter.convert_to('123', :integer)).to eq 123 }
  it { expect(converter.convert_to(123, :string)).to eq '123' }
  it { expect(converter.convert_to('   ', :integer)).to be_nil }
  it { expect(converter.convert_to(nil, :integer)).to be_nil }
  it { expect(converter.convert_to(nil, [:integer])).to be_empty }
  it { expect(converter.convert_to(%w(1 2 3), [:integer])).to eq [1, 2, 3] }
  it { expect(converter.convert_to(nil, :string)).to be_nil }
  it { expect(converter.convert_to(%w(hello world !!!), [:string])).to eq %w(hello world !!!) }
  it { expect(converter.convert_to(nil, :date)).to be_nil }
  it { expect(converter.convert_to(nil, :datetime)).to be_nil }
  it { expect(converter.convert_to({}, DaisybillApi::Models::Address)).to be_a DaisybillApi::Models::Address }

  context 'convert collection of hashes to collection of models' do
    let(:clazz) { DaisybillApi::Models::Address }
    subject { converter.convert_to([{}, {}, {}], [clazz]) }

    it { is_expected.to be_a Array }
    it { is_expected.to have(3).models }
    it { is_expected.to all( be_a clazz ) }
  end

  it 'when converting model' do
    clazz = DaisybillApi::Models::Address
    expect(converter.convert_to(clazz.new, clazz)).to be_a clazz
  end
  it { expect(converter.convert_to('{}', DaisybillApi::Models::Address)).to be_nil }
  it { expect{ converter.convert_to('some value', :unknown) }.to raise_error }
end
