require 'sidekiq/web'

Rails.application.routes.draw do
  get 'sessions/new'

  mount Sidekiq::Web => '/sidekiq'

  namespace 'admin' do
    get 'contest' => 'contests#show'
    get 'scoreboard' => 'scoreboard#show', as: :contest_scoreboard

    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :problems
  end

  get "/admin" => redirect("/admin/contest")

  root to: 'welcome#index'
end
