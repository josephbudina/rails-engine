Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'merchants/:id/items', to: 'merchants/merchant_items#index'
      get 'items/:id/merchant', to: 'items/items_merchant#index'
      get 'merchants/find', to: 'merchants/find#show'
      resources :merchants, only: [:index, :show] do
      end
      get 'items/find_all', to: 'items/find_all#index'
      resources :items
    end
  end
end