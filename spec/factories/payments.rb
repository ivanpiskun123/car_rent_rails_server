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
#
# Indexes
#
#  index_payments_on_car_rent_id  (car_rent_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_rent_id => car_rents.id)
#
FactoryBot.define do
  factory :payment, class: Payment do
    amount { 500 }
    is_paid { false }
    association :car_rent
  end
end
