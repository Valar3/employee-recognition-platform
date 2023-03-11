# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  namespace :employees do
    resources :kudos
    resources :rewards, only: [:index, :show]
     resources :orders, only: [:create, :new], module: :rewards

  end
  namespace :admins do
    resources :kudos, only: [:index, :destroy]
    resources :employees, only: [:index, :edit, :update, :destroy]
    resources :company_values
    resources :rewards
  end
  get '/admin' => "admins/pages#dashboard", :as => :admin_root
  root 'employees/kudos#index'
end
