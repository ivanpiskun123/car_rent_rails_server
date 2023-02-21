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
FactoryBot.define do
  factory :payment_card do
    code { "1234 5678 9012 3456" }
    cvv { "123" }
    date_exp { "12/23" }
    user
  end
end
