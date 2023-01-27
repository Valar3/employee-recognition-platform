# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees
  resources :kudos
  root 'kudos#index'
end
