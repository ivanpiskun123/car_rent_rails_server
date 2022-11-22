# == Schema Information
#
# Table name: fuel_types
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :fuel_type, class: FuelType  do
    name { Faker::Vehicle.fuel_type }
  end
end
