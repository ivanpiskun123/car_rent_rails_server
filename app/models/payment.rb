# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  amount      :integer          default(0), not null
#  is_paid     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  car_rent_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_payments_on_car_rent_id  (car_rent_id)
#  index_payments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_rent_id => car_rents.id)
#  fk_rails_...  (user_id => users.id)
#
class Payment < ApplicationRecord

  validates :amount, numericality: {greater_than_or_equal_to: 0}

  belongs_to :car_rent
  belongs_to :user


  def paid!
    self.update(is_paid: true)
    self.car_rent.paid!
  end

end
