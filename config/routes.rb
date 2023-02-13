# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  resources :kudos
  get '/employee' => "kudos#index", :as => :employee_root
  get '/admin' => "pages#dashboard", :as => :admin_root
  root 'kudos#index'
end
