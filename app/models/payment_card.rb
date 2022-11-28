# == Schema Information
#
# Table name: payment_cards
#
#  id         :bigint           not null, primary key
#  code       :string           default(""), not null
#  cvv        :string           default(""), not null
#  date_exp   :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_payment_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PaymentCard < ApplicationRecord

  validates :code, :cvv, :date_exp, presence: true

  belongs_to :user

end
