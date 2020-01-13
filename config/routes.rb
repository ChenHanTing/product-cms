Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      get 'status', on: :member
    end
  end

  devise_for :users

  root to: 'welcome#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
