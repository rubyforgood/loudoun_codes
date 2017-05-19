require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope module: 'admin' do
    get 'admin/scoreboard' => 'scoreboard#show'
  end

  root to: 'welcome#index'
end
