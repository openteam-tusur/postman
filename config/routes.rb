require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

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
  post '/api/webhooks/mailgun' => 'webhooks#mailgun_webhook'

  root :to => 'application#index'
end
