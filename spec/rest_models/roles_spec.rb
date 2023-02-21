RSpec.describe Role, type: :model do
  subject { build(:role) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:users) }
  end
end
