Rails.application.routes.draw do
  devise_for :admins
  root 'posts#index'
  
  devise_for :users
  resources :posts do
    resources :charges
    resources :likes
    resources :comments do
      resources :likes
    end
  end

  resources :tags
  resources :orders
end