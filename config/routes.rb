Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  resources :users, only: [:index, :show]
  resources :microposts, only: [:create, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :destroy]
  end
  resources :likes, only: :destroy
  resources :comments, only: [:new, :create, :destroy]
  resources :friendships, only: [:create, :update, :destroy] do
    member do
      get 'friends'
    end
  end
end
