# == Schema Information
#
# Table name: car_rents
#
#  id         :bigint           not null, primary key
#  ended_at   :datetime
#  is_paid    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_car_rents_on_car_id   (car_id)
#  index_car_rents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_id => cars.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe CarRent, type: :model do
  let(:car_rent) {build(:car_rent)}

  describe 'associations' do
    it { expect(car_rent).to belong_to(:car) }
    it { expect(car_rent).to belong_to(:user) }
  end

  describe 'model methods' do
    describe '#ended?' do
      it "rent not ended" do
        expect(car_rent.ended_at).to be_nil
      end
    end

    describe '#ended!' do
        before do
          car_rent.ended!
        end

        it "rent ended" do
          expect(car_rent.ended_at).to_not be_nil
          expect(car_rent.ended_at.to_date).to eq(Date.today)
        end
    end
  end
end
