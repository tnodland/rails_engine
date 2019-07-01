Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      namespace :merchants do
        get '/find', to: 'merchant_finder#show'
        get '/find_all', to: 'merchant_finder#index'
        get '/random', to: 'random_merchant#show'
        get '/most_revenue', to: 'revenue#index'
        get 'revenue', to: 'revenue_date#show'
        get ':id/revenue', to: 'revenue#show'
        get ':id/favorite_customer', to: 'customers#show'
        get ':id/items', to: 'items#index'
        get 'most_items', to: 'most_items#index'
      end

      resources :items, only: [:index]
      namespace :items do
        get 'most_revenue', to: 'revenue#index'
        get 'most_items', to: 'items_sold#index'
        get ':id/best_day', to: 'items_sold#show'
        get ':id/merchant', to: 'merchant#show'
      end

      resources :customers, only: [:index]

      resources :invoices, only: [:index]
      namespace :invoices do
        get ':id/transactions', to: 'transactions#index'
      end
      resources :transactions, only: [:index]
    end
  end
end
