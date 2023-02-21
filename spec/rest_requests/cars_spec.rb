require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  describe "GET #index" do
    it "renders all cars when 'renting' parameter is not present" do
      car1 = create(:car)
      car2 = create(:car)
      get :index
      expect(response).to have_http_status(:ok)
      expect(response_body['data'].count).to eq(2)
    end

    it "renders only rentable cars when 'renting' parameter is present" do
      car1 = create(:car, ready_to_rent: false)
      car2 = create(:car, ready_to_rent: true)
      car3 = create(:car, ready_to_rent: true)
      create(:car_rent, car: car2)
      get :index, params: { renting: true }
      expect(response).to have_http_status(:ok)
      expect(response_body['data'].count).to eq(1)
    end
  end

  describe "GET #show" do
    it "renders a car with the given id" do
      car = create(:car)
      get :show, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(response_body['data']['id']).to eq(car.id)
    end
  end

  describe "PATCH #to_repair" do
    it "sets ready_to_rent to false" do
      car = create(:car, ready_to_rent: true)
      patch :to_repair, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(response_body['data']['ready_to_rent']).to eq(false)
    end
  end

  describe "PATCH #to_rent" do
    it "sets ready_to_rent to true" do
      car = create(:car, ready_to_rent: false)
      patch :to_rent, params: { id: car.id }
      expect(response).to have_http_status(:ok)
      expect(response_body['data']['ready_to_rent']).to eq(true)
    end
  end

  describe "POST #create" do
    let(:worker) { create(:worker) }
    let(:user) { create(:user) }
    let!(:premium_for_score1) { create(:premium_for_score, score: 100, amount: 50) }
    let!(:premium_for_score2) { create(:premium_for_score, score: 200, amount: 100) }
    let!(:premium_for_score3) { create(:premium_for_score, score: 300, amount: 200) }

    context "when parameters are valid" do
      it "creates a new bid and returns it" do
        post :create, params: { bid: { worker_id: worker.id, user_id: user.id, sum_points: 250 } }
        expect(response).to have_http_status(:ok)
        expect(response_body['data']['worker_id']).to eq(worker.id)
        expect(response_body['data']['user_id']).to eq(user.id)
      end
    end

    context "when sum_points parameter is not present" do
      it "returns an error message" do
        post :create, params: { bid: { worker_id: worker.id, user_id: user.id } }
        expect(response).to have_http_status(:bad_request)
        expect(response_body['client_message']).to eq("Please check if typed data is correct")
        expect(response_body['error_message']).not_to be_empty
      end
    end
  end
end
