# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'

  devise_for :users
  devise_scope :user do
    get '/signup', to: 'devise/registrations#new'
    post '/signup', to: 'devise/registrations#create'

    get '/login', to: 'devise/sessions#new'
    post '/login', to: 'devise/sessions#create'
    delete '/logout', to: 'devise/sessions#destroy'

    get 'reset_password', to: 'devise/passwords#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :friendships, only: %i[create destroy index]
  resources :friend_requests, only: %i[create destroy index] do
    collection { post :mark_as_read }
  end
  resources :posts, only: %i[create destroy update edit show]

  # allow notifications to be marked as read
  resources :notifications, only: [:index] do
    collection { post :mark_as_read }
  end
end
