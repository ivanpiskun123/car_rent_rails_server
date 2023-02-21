# == Schema Information
#
# Table name: images
#
#  id             :bigint           not null, primary key
#  image_url      :string           not null
#  reference_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reference_id   :bigint
#
# Indexes
#
#  index_images_on_reference  (reference_type,reference_id)
#
FactoryBot.define do
  factory :image do
    image_url { Faker::Internet.url }
    reference_type { 'Car' }
    association :reference, factory: :car
  end
end
