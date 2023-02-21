RSpec.describe CarBrand, type: :model do

  subject { described_class.new(name: "Tesla") }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:cars) }
  end

end
