Rails.application.routes.draw do
  get 'games/main'
  devise_for :users
  root to: 'story#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :units, only: :index
  resources :user_units, only: :create
  get 'inventory', to: "user_resources#index"
  get 'inventory/:id', to: "user_resources#update"
  get 'base', to: "games#index"
  patch 'base', to: "games#update"
  get 'story', to: "story#show"
end
