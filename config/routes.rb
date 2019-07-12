# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notifications/index'
  devise_for :users

  root 'users#index'

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

  resources :friend_requests, only: %i[create destroy]

  # allow notifications to be marked as read
  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
    end
  end
end
