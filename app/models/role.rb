# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string           default("t"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :users

end
