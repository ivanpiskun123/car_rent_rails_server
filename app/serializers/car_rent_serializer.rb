# == Schema Information
#
# Table name: car_rents
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  is_paid    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_car_rents_on_car_id   (car_id)
#  index_car_rents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_id => cars.id)
#  fk_rails_...  (user_id => users.id)
#
class CarRentSerializer
  include JSONAPI::Serializer
  attributes :is_paid

  attribute :ended_at do |obj|
    obj.ended_at&.strftime("%H:%M %d-%m-%Y")
  end

  attribute :created_at do |obj|
    obj.created_at.strftime("%H:%M %d-%m-%Y")
  end

  attribute :calc_amount do |obj|
    obj.calc_amount
  end

  belongs_to :car, meta: Proc.new {|o,p|
    {
      car_image: o&.car&.image&.image_url,
      full_name: "#{o.car.car_brand.name} #{o.car.name}",
      edition_year: o.car.edition_year
    }
  }

  belongs_to :user, meta: Proc.new { |o,p|
    {
      phone: o.user.phone,
      email: o.user.email,
      full_name: o.user.full_name,
    }
  }

end
