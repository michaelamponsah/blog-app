Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  get '/posts/new', to: 'posts#new'
  post '/posts/new', to: 'posts#create'
  post '/comments/:post_id', to: 'comments#create'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
