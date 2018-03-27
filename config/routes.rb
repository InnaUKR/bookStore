Rails.application.routes.draw do
  resources :orders
  resources :line_items, only: %i[show destroy create]
  resources :carts, only: %i[show create]
  resources :books, path: 'catalog' do
    collection do
      get :recent
      get :price_low_to_hight
      get :price_hight_to_low
      get :title_a_z
      get :title_z_a
    end
  end
end