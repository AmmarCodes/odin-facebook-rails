# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:show]
  put '/users/:id/add_friend', to: 'users#send_friend_request', as: 'add_friend'
end
