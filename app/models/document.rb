# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  status     :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_documents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Document < ApplicationRecord
  include Imagable

  validates :status, presence: true, inclusion: [0..2]
  belongs_to :user

  def reject!
    self.update(status: 0)
  end

  def approve!
    self.update(status: 2)
  end


end
