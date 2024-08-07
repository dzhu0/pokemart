Rails.application.routes.draw do
  root 'pokemon_cards#index'
  resources :pokemon_cards, only: [:index, :show]
  resources :types, only: [:show]

  resources :search, only: [:index]
  resources :abouts, only: [:index]
  resources :contacts, only: [:index]

  resources :cart, only: [:index, :create, :update, :destroy]

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :customers
  scope '/customers' do
    resources :orders, only: [:index, :show, :new, :create] do
      get 'edit_shipping_address', on: :collection
      post 'update_shipping_address', on: :collection
    end
  end

  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
