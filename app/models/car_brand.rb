# == Schema Information
#
# Table name: car_brands
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CarBrand < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :cars

end
