Rails.application.routes.draw do
  resources :line_items, only: [:show, :destroy, :create]
  resources :carts, only: [:show, :create]
  resources :books, :formats => [:haml, :html], only: [:show, :index]
end