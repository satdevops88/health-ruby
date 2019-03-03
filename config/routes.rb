Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :events, only: [:create]
    resources :products, only: [:index]
    resources :recommendations, only: [:index]

    namespace :admin do
      resources :brands, only: [:destroy, :update]
      resources :categories, only: [:create, :destroy, :index, :update]
      resources :products, only: [:create, :destroy, :update]
      resources :retailer_categories, only: [:index]
      resources :retailer_products, only: [:create, :destroy, :update]
      resources :retailers, only: [:index]
      resources :users, only: [:create, :destroy, :update]
    end
  end

  devise_for :users, controllers: { sessions: 'sessions' }, skip: [ :passwords, :registrations ]
  namespace :admin do
    get '/' => 'dashboard#index'
    resources :brands, only: [:edit, :index]
    resources :categories, only: [:edit, :index]
    resources :products, only: [:edit, :index]
    resources :retailer_products, only: [:edit, :index]
    resources :users, only: [:edit, :index]
    resources :events, only: [:edit, :index]
  end

  resources :retailers, only: [] do
    collection do
      get :scrape, constraints: { format: :js }
    end
  end

  # Catch all routes for the client side app
  get '/' => 'app#app', as: 'app'
  get '*app' => 'app#app'
end
