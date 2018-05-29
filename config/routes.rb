Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers:
      {
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  resources :line_items, only: %i[show destroy create] do
    put :up_quantity
    put :down_quantity
  end
  resources :carts, only: :show
  resources :books, only: :show do
    put :change_quantity
    resources :reviews
  end
  resources :categories, only: :index
  resources :orders
  root 'home#index'
  resources :checkouts
end