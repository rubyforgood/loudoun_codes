require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope module: 'admin' do
    get 'admin/contests/:contest_id/scoreboard' => 'scoreboard#show', as: :admin_contest_scoreboard
  end

  root to: 'welcome#index'
end
