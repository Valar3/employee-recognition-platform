# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  namespace :employees do
    resources :kudos
    resources :rewards, only: [:index, :show]
    resources :orders, only: [:create, :index, :show]
  end
  namespace :admins do
    resources :kudos, only: [:index, :destroy]
    resources :employees, only: [:index, :edit, :update, :destroy] do
      resources :orders_2, only: [:index, :update]
    end
    resources :company_values
    resources :rewards
    resources :orders, only: [:index, :update]

  end
  get '/admin' => "admins/pages#dashboard", :as => :admin_root
  root 'employees/kudos#index'
end
