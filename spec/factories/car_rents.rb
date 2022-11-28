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
FactoryBot.define do
  factory :car_rent, class: CarRent do
    association :car
    association :user
    is_paid { false }
    ended_at { nil }
  end
end
