# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  first_name         :string           default(""), not null
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
    
  end
end
