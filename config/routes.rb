# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: {sessions: 'admin/sessions' }
  devise_for :employees, path: 'employees', controllers: {sessions: 'employee/sessions' }
  root 'kudos#index'
end
