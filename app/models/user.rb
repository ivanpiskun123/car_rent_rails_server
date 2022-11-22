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
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Imagable


  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true
  validates :first_name, :second_name, presence: true

  belongs_to :role
  has_many :car_rents
  has_many :payments
  has_many :documents
  has_one :document


  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end

  def lock!
    self.update(locked: true, locked_at: Time.now)
  end

  def unlock!
    self.update(locked: false)
  end

end
