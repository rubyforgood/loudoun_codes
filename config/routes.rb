require 'sidekiq/web'

Rails.application.routes.draw do
  get 'sessions/new'

  resources :submissions

  mount Sidekiq::Web => '/sidekiq'

  namespace 'admin' do
    get 'contest' => 'contests#show'
    get 'scoreboard' => 'scoreboard#show', as: :contest_scoreboard

    resources :problems, only: [:create, :new, :edit, :update, :destroy]

    resources :attachments, only: [:destroy]

    resources :teams
  end

  resources :problems, only: [:index, :show]

  resources :attachments, only: [:show]

  resources :sessions, only: [:new, :create, :destroy]
  get 'login',  to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  get "/admin" => redirect("/admin/contest")

  root to: 'problems#index'
end
