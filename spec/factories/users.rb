# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  first_name         :string           default(""), not null
#  jti                :string           default(""), not null
#  locked             :boolean          default(FALSE), not null
#  locked_at          :datetime
#  phone              :string           default(""), not null
#  second_name        :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  role_id            :bigint
#
# Indexes
#
#  index_users_on_email    (email) UNIQUE
#  index_users_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password {'password'}
    password_confirmation {'password'}
    first_name { Faker::Name.first_name }
    second_name { Faker::Name.last_name }
    jti { Faker::Alphanumeric.alpha(number: 10) }
    phone { Faker::PhoneNumber.phone_number }
    locked { false }
    association :role
  end
end
