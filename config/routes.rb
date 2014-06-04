Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root 'posts#index'
  
  resources :posts do
    resource :map
    resources :charges
    resources :likes
    resources :comments do
      resources :likes
    end
  end

  resources :tags
  resources :orders
end