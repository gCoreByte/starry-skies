# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  constraints subdomain: '' do # rubocop:disable Metrics/BlockLength
    # Authentication from auth-zero
    get  'sign_in', to: 'sessions#new'
    post 'sign_in', to: 'sessions#create'
    get  'sign_up', to: 'registrations#new'
    post 'sign_up', to: 'registrations#create'

    resources :sessions, only: %i[index destroy]
    resource  :password, only: %i[edit update]
    namespace :identity do
      resource :email,              only: %i[edit update]
      resource :email_verification, only: %i[show create]
      resource :password_reset,     only: %i[new edit create update]
    end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get 'up' => 'rails/health#show', as: :rails_health_check

    # Authenticated routes
    namespace :admin do # rubocop:disable Metrics/BlockLength
      resources :dashboard, only: :index
      resources :stores, except: :index do # rubocop:disable Metrics/BlockLength
        resources :products, shallow: true do
          resources :product_versions, shallow: true do
            member do
              patch :activate
              patch :deactivate
              patch :translations
              get :translations_form
            end
            resources :product_version_categories, only: %i[new create destroy], shallow: true
            resources :product_prices, shallow: true, except: %i[index]
          end
        end

        resources :product_categories, shallow: true
        resources :admin_store_permissions, only: %i[index create destroy]
        resources :admin_store_relationships, only: %i[index create destroy]
        resources :purchase_orders, shallow: true, except: %i[edit update] do
          member do
            patch :processing
            patch :in_transit
            patch :completed
            patch :failed
          end
        end

        resources :page_templates, shallow: true do
          member do
            patch :activate
            patch :deactivate
          end

          resources :page_translations, shallow: true
        end
        resources :pages, shallow: true, except: %i[edit update] do
          member do
            get :preview
            patch :draft
            patch :live
          end
        end
        resources :user_groups, shallow: true
        resources :user_accounts, shallow: true, only: %i[index show] do
          resources :user_user_groups, only: %i[new create destroy], shallow: true
        end
      end
    end

    get '/about', to: 'home#about'
    get '/contact_us', to: 'home#contact_us'
    get '/pricing', to: 'home#pricing'
    root 'home#index', as: :admin_root
  end

  scope module: 'user' do
    resources :user_accounts, only: %i[new create]
    resources :user_sessions, only: %i[new create destroy]
    # resources :pages, only: %i[index show]
    get '/p(/:slug(/:record_type/:record_id))', to: 'pages#show'
    resources :purchase_carts, only: %i[show destroy] do
      member do
        patch :add_item
        patch :remove_item
      end
    end

    root 'pages#show', as: :user_root
  end

  root 'home#index'
end
