Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about", to: "homes#about"

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :chat_rooms, only: [:show]
  resources :chat_messages, only: [:create]
end
