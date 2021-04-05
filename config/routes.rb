Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'merchants/items', to: 'merchants/merchant_items#index'
      resources :merchants, only: [:index, :show] do
      end
    resources :items
    end
  end
end