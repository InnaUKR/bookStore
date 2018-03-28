Rails.application.routes.draw do
  resources :orders
  resources :line_items, only: %i[show destroy create]
  resources :carts, only: %i[show create]
  resources :books
  resources :categories, only: :index
end