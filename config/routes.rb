require 'sidekiq/web'
Rails.application.routes.draw do
  get 'sessions/new'

  resources :submissions

  mount Sidekiq::Web => '/sidekiq'

  namespace 'admin' do
    resource 'contest'

    get 'scoreboard' => 'scoreboard#show', as: :contest_scoreboard

    get    'login',  to: 'sessions#new'
    post   'login',  to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :problems, only: [:create, :new, :edit, :update, :destroy]

    resources :attachments, only: [:destroy]

    resources :teams
  end

  resources :problems, only: [:index, :show]

  resources :attachments, only: [:show]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get "/admin" => redirect("/admin/contest")

  root to: 'welcome#index'
end
