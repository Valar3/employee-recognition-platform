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
    patch 'update_add_kudos_to_all/', to: 'employees#update_add_kudos_to_all'
    get  'edit_add_kudos_to_all/', to: 'employees#edit_add_kudos_to_all'
    resources :employees, only: [:index, :edit, :update, :destroy] do
      resources :orders, only: [:index, :update]
      patch 'mass_edit/', to: 'mass_edit#update'
      get 'mass_edit/', to: 'mass_edit#edit'
      end
    namespace :employees do
      resources :orders, only: [:index, :update]
    end
    resources :company_values
    resources :rewards


  end
  get '/admin' => "admins/pages#dashboard", :as => :admin_root
  root 'employees/kudos#index'
end
