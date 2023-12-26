# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :sessions
  resource :admins

  scope module: :unauthenticated do
    get '/about', to: 'home#about'
    get '/contact_us', to: 'home#contact_us'
    get '/pricing', to: 'home#pricing'

    root 'home#index'
  end
end
