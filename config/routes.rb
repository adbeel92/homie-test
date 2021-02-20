# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :api_admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :token, only: %i[create]
      resources :properties
    end
  end
end
