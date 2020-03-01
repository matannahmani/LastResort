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
  patch 'base', to: "games#update"
  post 'games/extract', to: "extracts#pick_up"
  get 'games/null', to: "games#null"
  get 'story', to: "stories#show"
end
