# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json } do
    scope ':budget_id' do
      resources :transactions, only: %i[index]

      resources :accounts, only: %i[index create show update] do
        resources :transactions, only: %i[index create update destroy]
      end

      resources :category_groups, only: %i[create] do
        resources :categories, only: %i[create]
      end
    end

    resources :budgets, only: %i[index create show update]

    resource :sessions, only: %i[create destroy show]
    resources :users, only: %i[create]
  end
end
