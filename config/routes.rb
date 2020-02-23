Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :units, only: [:index, :create, :update]
  resources :resources, only: [:index, :create, :update]
  get 'base', to: "game#index"
  patch 'base', to: "game#update"
  get 'story', to: "stories#show"
end
