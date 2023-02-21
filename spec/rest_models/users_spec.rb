require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:second_name) }
  end

  describe "associations" do
    it { should belong_to(:role) }
    it { should have_many(:car_rents) }
    it { should have_many(:payments).through(:car_rents) }
    it { should have_one(:document) }
    it { should have_one(:payment_card) }
  end

  describe "methods" do
    let(:user) { FactoryBot.build(:user) }

    it "generates JWT" do
      jwt = user.generate_jwt
      expect(jwt).not_to be_nil
    end

    it "locks user" do
      user.lock!
      expect(user.locked).to eq(true)
    end

    it "unlocks user" do
      user.unlock!
      expect(user.locked).to eq(false)
    end

    it "returns full name" do
      expect(user.full_name).to eq("#{user.first_name} #{user.second_name}")
    end
  end

end
