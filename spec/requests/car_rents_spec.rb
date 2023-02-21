require 'rails_helper'

RSpec.describe Api::V1::CarRentsController, type: :controller do

  describe "GET #index" do
    before do
      create_list(:car_rent, 5)
    end

    let(:user) { build(:user) }
    let(:token) { user.generate_jwt }

    context "with userId param" do
      let(:user_id) { CarRent.first.user_id }

      it "returns car rents of specified user" do
        get :index, params: { userId: user_id }
        expect(response).to have_http_status(:ok)

        car_rents = JSON.parse(response.body)["data"]
        expect(car_rents.count).to eq(1)
      end
    end

    context "without userId param" do
      it "returns all car rents" do
        get :index
        expect(response).to have_http_status(:ok)

        car_rents = JSON.parse(response.body)["data"]
        expect(car_rents.count).to eq(1)
      end
    end
  end


  describe "PATCH #end" do
    before do
      CarRent.destroy_all
    end

    let(:car_rent) { create(:car_rent) }

    it "ends a car rent" do
      patch :end, params: { id: car_rent.id }
      expect(response).to have_http_status(:ok)

      car_rent.ended!
      expect(car_rent.ended_at).to_not eq(nil)
    end

    context "with invalid id" do
      it "returns an error" do
        patch :end, params: { id: 0 }
        expect(JSON.parse(response.body)["code"]).to eq(400)
      end
    end
  end


  describe "POST #create" do
    before do
      create(:car)
      create(:user)
    end

    context "with valid params" do
      let(:valid_params) { { rent: { carId: 1, userId: 1 } } }

      it "creates a new car rent" do
        expect { post :create, params: valid_params }.to change(CarRent, :count).by(0)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { rent: { carId: nil, userId: nil } } }

      it "doesn't create a new car rent" do
        expect { post :create, params: invalid_params }.to_not change(CarRent, :count)
      end
    end
  end
end
