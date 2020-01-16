Rails.application.routes.draw do
  namespace :client do
    resources :products, only: %i[index show]
  end

  namespace :admin do
    resources :products do
      get 'status', on: :member
    end
  end

  devise_for :users

  root to: 'client/products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
