require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      before { get :index }
      it { expect(response).to have_http_status(:ok) }

      it 'returns the list of users with role id 1' do
        expect(JSON.parse(response.body)['data'].length).to eq(User.where(role_id: 1).count)
      end
    end

    context 'when user is authenticated' do
      let(:user) { create(:user, role_id: 2) }
      before { sign_in user }

      it 'returns 401 status code' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    before { get :show, params: { id: user.id } }

    it { expect(response).to have_http_status(:ok) }

    it 'returns the user with the given id' do
      expect(JSON.parse(response.body)['data']['id']).to eq(user.id)
    end
  end

  describe 'GET #short_show' do
    let(:user) { create(:user) }
    before { get :short_show, params: { id: user.id } }

    it { expect(response).to have_http_status(:ok) }

    it 'returns a shorter version of the user with the given id' do
      expect(JSON.parse(response.body)['data']['id']).to eq(user.id)
      expect(JSON.parse(response.body)['data']).to_not have_key('email')
      expect(JSON.parse(response.body)['data']).to_not have_key('document')
    end
  end

  describe 'PUT #approve_doc' do
    let(:user) { create(:user) }
    let(:document) { create(:document, user: user, status: 1) }
    before { put :approve_doc, params: { id: user.id } }

    it { expect(response).to have_http_status(:ok) }

    it 'changes the status of the document to approved' do
      expect(document.reload.status).to eq(2)
    end

    it 'returns "Approved"' do
      expect(JSON.parse(response.body)['data']).to eq('Approved')
    end
  end

  describe 'PUT #reject_doc' do
    let(:user) { create(:user) }
    let(:document) { create(:document, user: user, status: 1) }
    before { put :reject_doc, params: { id: user.id } }

    it { expect(response).to have_http_status(:ok) }

    it 'changes the status of the document to rejected' do
      expect(document.reload.status).to eq(0)
    end

    it 'returns "Reject"' do
      expect(JSON.parse(response.body)['data']).to eq('Reject')
    end
  end
end
