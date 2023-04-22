Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  get '/posts/new', to: 'posts#new'
  post '/posts/new', to: 'posts#create'
  post '/comments/:post_id', to: 'comments#create'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  namespace :api do
    namespace :v1 do
      post 'login', to: 'login#index'
      resources :users, only: [:index] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

end
