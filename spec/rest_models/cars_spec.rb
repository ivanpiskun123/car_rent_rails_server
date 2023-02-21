require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car_brand) { CarBrand.create(name: "Brand") }
  let(:fuel_type) { FuelType.create(name: "Gasoline") }

  subject {
    described_class.new(name: "Car",
                        price_per_min: 1.5,
                        engine_volume: 2.0,
                        edition_year: 2022,
                        condition: 9,
                        car_brand_id: car_brand.id,
                        fuel_type_id: fuel_type.id)
  }

  describe 'validations' do
    it { should validate_numericality_of(:price_per_min).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:engine_volume).is_greater_than_or_equal_to(0.1).is_less_than(20.0) }
    it { should validate_numericality_of(:edition_year).is_greater_than_or_equal_to(1900).is_less_than(Time.now.year + 1) }
    it { should validate_numericality_of(:condition).is_less_than(11).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should belong_to(:fuel_type) }
    it { should belong_to(:car_brand) }
    it { should have_many(:car_rents) }
  end

  describe '#to_restore!' do
    it 'sets ready_to_rent to false' do
      subject.update(ready_to_rent: true)
      subject.to_restore!
      expect(subject.ready_to_rent).to eq(false)
    end
  end

  describe '#to_rent!' do
    it 'sets ready_to_rent to true' do
      subject.update(ready_to_rent: false)
      subject.to_rent!
      expect(subject.ready_to_rent).to eq(true)
    end
  end

  describe '#full_name' do
    it 'returns the full name of the car' do
      expect(subject.full_name).to eq("#{car_brand.name} #{subject.name}")
    end
  end
end
