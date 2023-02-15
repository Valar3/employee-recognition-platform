# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  resources :kudos
  namespace :admin do
    resources :kudos
  end
  resources :pages
  get '/admin' => "pages#dashboard", :as => :admin_root
  root 'kudos#index'
end
