# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :users, only: [:show]
  get '/friends', to: 'users#friends', as: 'friends'
  put '/users/:id/add_friend', to: 'users#send_friend_request', as: 'add_friend'
  put '/users/:id/confirm_friend', to: 'users#confirm_friend_request', as: 'confirm_friend'

  get '/notifications', to: 'notifications#index', as: 'notifications'

  resources :posts
  put '/posts/:id/like', to: 'posts#like', as: 'like'
  put '/posts/:id/dislike', to: 'posts#dislike', as: 'dislike'
end
