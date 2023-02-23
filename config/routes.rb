# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  resources :kudos
  namespace :admins do
    resources :kudos, only: [:index, :destroy]
    resources :employees, only: [:index, :edit, :update, :destroy]
    resources :company_values
  end
  get '/admin' => "admins/pages#dashboard", :as => :admin_root
  root 'kudos#index'
end
