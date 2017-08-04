require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { User.create!(email: 'testcontroller@rspec.com', password: 'R$p3c!') }
  let(:user2) { User.create!(email: 'testcontroller2@rspec.com', password: 'R$sp3c!!') }

  describe 'GET #show' do
    context 'when a user is logged in' do
      before do 
        sign_in user
      end

      it 'loads the user details' do
        get :show, params: { id: user.id }
        expect(response.status).to eq 200
        expect(assigns(:user)).to eq user
      end

      it 'roots to the root page' do
        get :show, params: { id: user2.id }
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when a user is not logged in' do
      it 'redirects to login page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end
    end

  end # end describe GET #show
end # end describe UserController