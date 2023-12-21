# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  # Defines the root path route ("/")
  unauthenticated do
    scope module: 'unauthenticated' do
      get '/about', to: 'home#about'
      get '/contact_us', to: 'home#contact_us'
      get '/pricing', to: 'home#pricing'

      root 'home#index'
    end
  end
end
