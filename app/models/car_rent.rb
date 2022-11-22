# == Schema Information
#
# Table name: car_rents
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  is_paid    :boolean
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
class CarRent < ApplicationRecord

  belongs_to :car
  belongs_to :user


  def ended!
    self.update(ended_at: Time.now)
  end

  def paid!
    self.update(is_paid: true)
  end

  def ended?
    ! self.ended_at.nil?
  end

end
