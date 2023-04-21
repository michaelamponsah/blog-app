require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Get /index' do
    before(:example) do
      get '/users'
    end

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'contains the correct text' do
      expect(response.body).to include('List of all users')
    end
  end

  describe 'Get/show' do
    before(:example) do
      get '/users/:user_id'
    end

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'contains the correct text' do
      expect(response.body).to include('Single user resource')
    end
  end
end
