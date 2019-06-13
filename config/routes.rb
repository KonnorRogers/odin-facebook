Rails.application.routes.draw do
  devise_for :users

  as :user do
    root 'devise/registrations#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
end
