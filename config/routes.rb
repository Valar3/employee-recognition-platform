# frozen_string_literal: true

Rails.application.routes.draw do
<<<<<<< HEAD
  root 'kudos#index'
  devise_for :employees
  resources :kudos
=======
  devise_for :employees
  root 'home#index'
>>>>>>> c2b5774... set root route, setup devise gem, added a navbar feature,added home button, added seeding
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
