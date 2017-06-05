shared_examples_for DaisybillApi::Ext::Associations do |*associations|
  context "ClassMethods" do
    subject { described_class }

    it { is_expected.to respond_to :has_many }
  end

  context "InstanceMethods" do
    associations.each do |association|
      it { is_expected.to respond_to association }
    end
  end
end
