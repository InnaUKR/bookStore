Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers:
      {
        registrations: 'users/registrations',
        omniauth_callbacks: 'auth/callbacks'
      }
  resources :orders
  resources :line_items, only: %i[show destroy create] do
    put :up_quantity
    put :down_quantity
  end
  resources :carts, only: :show
  resources :books, only: :show
  resources :categories, only: :index
  root 'home#index'
end