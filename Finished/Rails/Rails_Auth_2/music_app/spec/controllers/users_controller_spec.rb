require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects user to log in on success' do
        post :create, params: { user: { email: 'user@gmail.com', password: 'password' } }

        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'with invalid params' do
      it 'validates presence of user\'s email and password' do
        post :create, params: { user: { email: '', password: '' } }

        expect(response).to redirect_to(new_user_url)
        expect(flash[:errors]).to be_present
      end

      it 'validates that the password is at least 6 characters long' do
        post :create, params: { user: { email: 'user@gmail.com', password: 'a' } }

        expect(response).to redirect_to(new_user_url)
        expect(flash[:errors]).to be_present
      end
    end
  end
end
