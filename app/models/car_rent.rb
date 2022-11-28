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
class CarRent < ApplicationRecord

  belongs_to :car
  belongs_to :user
  has_one :payment

  before_validation :check_if_uniq_for_car, on: [:create, :update]

  def check_if_uniq_for_car
    return true if self.is_paid
    cr = CarRent.where(is_paid: false, car: self.car)

    unless cr.empty?
      return true if cr.count == 1 and cr.last.id == self.id
      self.errors.add(:car, "Already there's such unpaid one")
    end
    true
  end


  def ended!
    ActiveRecord::Base.transaction do
      self.update(ended_at: Time.now)

      Payment.create!(
        {
          car_rent: self,
          amount: calc_amount
        }
      )
    end
  end

  def paid!
    self.update(is_paid: true)
  end

  def ended?
    ! self.ended_at.nil?
  end

  def calc_amount
    unless self.payment.nil?
      self.payment.amount
    else
      ((ended? ? ended_at - created_at : Time.now - created_at) / 1.minute).round * car.price_per_min
    end
  end

end
