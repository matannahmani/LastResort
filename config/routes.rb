Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :units, only: :index
  resources :user_units, only: :create
  get 'inventory', to: "user_resources#index"
  get 'inventory/:id', to: "user_resources#update"
  get 'base', to: "game#index"
  patch 'base', to: "game#update"
  get 'story', to: "stories#show"
end
