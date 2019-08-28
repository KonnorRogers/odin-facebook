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

  resources :users, only: %i[show index]
  resources :friendships, only: %i[create destroy index]

  # allows for marking a notifications as read
  # POST /friend_requests/mark_as_read
  resources :friend_requests, only: %i[create destroy index] do
    collection { post :mark_as_read }
  end

  # allow notifications to be marked as read
  resources :notifications, only: [:index] do
    collection { post :mark_as_read }
  end

  # Allows comments to be referrable from posts
  # GET /posts/:post_id/comments/:comment_id
  # GET /posts/:post_id/likes/:like_id
  resources :posts, only: %i[create destroy update edit show] do
    resources :comments, only: %i[show]
    resources :likes, only: %i[show]
  end

  # allows nested comments / likes ie:
  # GET /comments/:comment_id/comments(:format)
  # GET /comments/:like_id/likes(:format)
  resources :comments, only: %i[create destroy edit show] do
    resources :comments, only: %i[show]
    resources :likes, only: %i[show]
  end
end
