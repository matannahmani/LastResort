Rails.application.routes.draw do
  get 'games/main'
  devise_for :users
  root to: 'stories#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :units, only: :index
  resources :user_units, only: [:create, :new]
  get 'inventory', to: "user_resources#index"
  get 'inventory/:id', to: "user_resources#update"
  get 'base', to: "games#index"
  get 'base/checkupdate', to: "games#getupdate"
  patch 'base', to: "games#update"
  post 'games/extract', to: "extracts#pick_up"
  post 'inventory/exchange', to: "user_resources#exchange"
  post 'structures/buy', to: "user_structures#build"
  post '/upload', to: "games#upload"
  post 'soldiers/buy', to: "user_units#create"
  get 'story', to: "stories#show"
  get 'base/raid', to: "games#raid"
  get '/raid/:id', to: "games#startraid"
  post '/games/mylocation', to: "extracts#updateresource"
end
