# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json } do
    scope ':budget_id' do
      resources :transactions, only: %i[index]

      resources :accounts, only: %i[create update] do
        resources :transactions, only: %i[create update destroy]
      end
    end

    resources :budgets, only: %i[index create update]

    resource :sessions, only: %i[create destroy show]
    resources :users, only: %i[create]
  end
end
