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
class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :first_name, :second_name, :phone, :locked

  attribute :created_at do |user|
    user.created_at.to_date
  end

  attribute :locked_at do |obj|
    obj.locked_at&.strftime("%H:%M %d-%m-%Y")
  end

  belongs_to :role, meta: Proc.new {|o,p|
    {
      name: o.role.name,
    }
  }

  has_one :image, meta: Proc.new {|o, _|
    {
      url: o.image.image_url
    }}

  has_one :document, meta: Proc.new {|o,p|
    {
      url: o.document&.image&.image_url,
      status: o.document&.status
    }
  }

  meta do |o|
    {
      total_rents_count: o.car_rents.count,
      active_rents_count: o.car_rents.where(ended_at: nil).count,
      paid_payments_count: o.payments.where(is_paid: true).count  ,
      total_payments_count: o.payments.count
    }
  end

end
