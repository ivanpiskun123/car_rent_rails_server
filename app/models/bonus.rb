# == Schema Information
#
# Table name: bonuses
#
#  id         :bigint           not null, primary key
#  amount     :integer          default(0), not null
#  is_used    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_bonuses_on_payment_id  (payment_id)
#  index_bonuses_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (user_id => users.id)
#
class Bonus < ApplicationRecord

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  belongs_to :user
  belongs_to :payment, optional: true

end
