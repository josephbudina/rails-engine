Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'merchants/:id/items', to: 'merchants/merchant_items#index'
      get 'items/:id/merchant', to: 'items/items_merchant#index'
      get 'merchants/find', to: 'merchants/find#show'
      get 'merchants/most_items', to: 'merchants/most_items#index'
      resources :merchants, only: [:index, :show] do
      end
      get 'items/find_all', to: 'items/find_all#index'
      resources :items
      namespace :revenue do
        get 'merchants', to: 'merchants#index'
        get 'merchants/:id', to: 'merchants#show'
        get 'items', to: 'items#index'
      end
    end
  end
end