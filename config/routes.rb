# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers:
      {
        registrations: 'users/registrations',
        omniauth_callbacks: "users/omniauth_callbacks"
      }
  resources :users, only: %i[edit]

  resources :line_items, only: %i[show destroy create] do
    put :up_quantity
    put :down_quantity
  end
  resources :books do
    put :change_quantity
    resources :reviews
  end
  resources :categories, only: :index
  resources :orders, only: %i[index update edit show] do
    get :cart
  end
  root 'home#index'
  resources :checkouts, only: %i[show update]
end
