RSpec.describe Document, type: :model do
  subject { described_class.new }

  describe "validations" do
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:status).is_less_than(3).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "#reject!" do
    it "changes status to 0" do
      document = create(:document, status: 2)
      document.reject!
      expect(document.status).to eq(0)
    end
  end

  describe "#approve!" do
    it "changes status to 2" do
      document = create(:document, status: 0)
      document.approve!
      expect(document.status).to eq(2)
    end
  end
end
