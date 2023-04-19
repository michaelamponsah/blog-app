require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example)  do
      get '/users/:user_id/posts'
    end

    it 'Returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'Displays the correct template' do
      expect(response).to render_template(:index)
    end

    it 'Contains the correct text' do
      expect(response.body).to include('user posts')
    end
  end

  describe 'Get /show' do
    before(:example) do
      get '/users/:user_id/posts/:post_id'
    end
    it 'Displays a successful response' do
      expect(response).to have_http_status(:ok)
    end
    it 'Displays the correct template' do
      expect(response).to render_template(:show)
    end
    it 'Contains the correct text' do
      expect(response.body).to include('Single Post of a user')
    end
  end
end
