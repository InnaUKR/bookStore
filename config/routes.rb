Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :orders
  resources :line_items, only: %i[show destroy create]
  resources :carts, only: %i[show create]
  resources :books
  resources :categories, only: :index
  root 'categories#index'
end