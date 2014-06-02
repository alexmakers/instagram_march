Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users
  resources :posts do
    resources :likes
    resources :comments do
      resources :likes
    end
  end

  resources :tags
end