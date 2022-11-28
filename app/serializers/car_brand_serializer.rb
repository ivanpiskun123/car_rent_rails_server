# == Schema Information
#
# Table name: car_brands
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CarBrandSerializer
  include JSONAPI::Serializer
  attributes 
end
