Rails.application.routes.draw do
  devise_for :users

  root 'users#index'

  devise_scope :user do
    get '/signup', to: 'devise/registrations#new'
    post '/signout', to: 'devise/regisrations#create'

    get '/login', to: 'devise/sessions#new'
    delete '/logout', to: 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
end
