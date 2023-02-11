# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  devise_for :employees, path: 'employees'
  resources :kudos
  resources :pages
  resources :choice
  get '/employee' => "kudos#index", :as => :employee_root
  get '/admin' => "kudos#index", :as => :admin_root
  root 'choice#index'
end
