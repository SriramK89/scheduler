Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :resources, only: [:index, :create, :update]
  resources :users, only: [:index, :create, :update]
  resources :resourceuserdistances, only: [:index, :create, :update]
  resources :resourceusages, only: [:index, :create, :update]
end
