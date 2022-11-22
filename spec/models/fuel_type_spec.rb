# == Schema Information
#
# Table name: fuel_types
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe FuelType, type: :model do
  let(:fuel_type) { build(:fuel_type) }

  context 'associations' do
    it { expect(fuel_type).to have_many(:cars) }
  end

  context "validations" do
    it 'are passed', :aggregate_failures do
      expect(fuel_type).to validate_presence_of(:name)
    end
  end

end
