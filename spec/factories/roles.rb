# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string           default("t"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "admin-#{n}" }
  end
end
