# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'properties#index'
  resources :properties, only: %i[index show]
end
