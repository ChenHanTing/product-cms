Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  namespace :client do
    resources :products, only: %i[index show] do
      post 'order', on: :member
    end
  end

  namespace :admin do
    resources :products do
      get 'status', on: :member
    end

    resources :order_discounts
  end

  namespace :test do
    resources :products, only: :index do
      collection do
        post :add_fav_products
        post :add_to_cart
        post :create_order
        get :my_cart
        get :my_orders
        get :my_fav_products
        get :my_order_detail
      end
    end

    resources :order_discounts
  end

  devise_for :users
  resources :users, only: %i[show edit update]

  root to: 'client/products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
