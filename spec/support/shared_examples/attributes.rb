shared_examples_for DaisybillApi::Ext::Attributes do |*attributes|
  all = attributes | [:created_at, :updated_at]
  let(:attrs) do
    all.each_with_object({}) { |name, result|
      type = described_class.attrs[name.to_s]
      result[name] = case type
        when :integer
          rand(201) - 100
        when :string
          Faker::Lorem.word
        when :date
          Date.new(rand(15) + 2000, rand(12) + 1, rand(28) + 1)
        when :datetime
          DateTime.new
        else
          raise "Unknown Attribute Type: #{type.inspect}"
      end
    }
  end

  subject { described_class.new attrs }

  all.each do |name|
    its(:attributes) { is_expected.to include name.to_s  }
    it { is_expected.to respond_to name }
    it { is_expected.to respond_to :"#{name}=" }
    its(name) { is_expected.to eq attrs[name] }
  end
end
