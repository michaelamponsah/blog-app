require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'Get/index' do
    before(:example) do
      get '/users/1/posts'
    end
    it 'Displays a successful response' do
      expect(response).to be_successful
    end
    it 'Displays the correct template' do
      expect(response).to render_template(:index)
    end
    it 'Contains the correct text' do
      expect(response.body).to include('Posts of a single user')
    end
  end

  describe 'Get/show' do
    before(:example) do
      get '/users/1/posts/1'
    end
    it 'Displays a successful response' do
      expect(response).to be_successful
    end
    it 'Displays the correct template' do
      expect(response).to render_template(:show)
    end
    it 'Contains the correct text' do
      expect(response.body).to include('Single Post of a user')
    end
  end
end
