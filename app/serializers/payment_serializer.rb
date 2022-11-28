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
class PaymentSerializer
  include JSONAPI::Serializer
  attributes 
end
