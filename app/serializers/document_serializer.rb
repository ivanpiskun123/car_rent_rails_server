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
class DocumentSerializer
  include JSONAPI::Serializer
  attributes 
end
