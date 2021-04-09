# == Route Map
#

Rails.application.routes.draw do
  devise_for :admins, only: %i[session], controllers: { sessions: 'admins/sessions' }
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :admins do
    root 'dashboard#index'
    resources :dashboard, only: %w[index edit update]
  end
end
