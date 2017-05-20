require 'sidekiq/web'

Rails.application.routes.draw do
  get 'sessions/new'

  mount Sidekiq::Web => '/sidekiq'

  namespace 'admin' do
    get 'contest' => 'contests#show'
    get 'scoreboard' => 'scoreboard#show', as: :contest_scoreboard

    get    'login',  to: 'sessions#new'
    post   'login',  to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :problems
  end

  resources :problems, only: [:index, :show]

  resources :attachments, only: [:show]

  get "/admin" => redirect("/admin/contest")

  root to: 'welcome#index'
end
