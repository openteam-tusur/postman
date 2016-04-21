require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount Api => '/'

  resources :messages, :only => [:index, :show]

  resources :contacts, :only => :show do
    get 'rehabilitate'
  end

  namespace :property do
    resources :emails
    resources :smses
  end

  post '/api/webhooks/sparkpost' => 'webhooks#catch_hook'

  root :to => 'application#index'
end
