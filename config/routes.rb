require 'sidekiq/web'

Rails.application.routes.draw do
  get 'sessions/new'

  mount Sidekiq::Web => '/sidekiq'

  scope module: 'admin' do
    get 'admin/contests/:contest_id/scoreboard' => 'scoreboard#show', as: :admin_contest_scoreboard
    post   'admin/login',   to: 'sessions#create'
    delete 'admin/logout',  to: 'sessions#destroy'
  end

  root to: 'welcome#index'
end
