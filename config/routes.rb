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

  scope :api do
    scope :webhooks do
      post :sparkpost, to: 'webhooks#catch_hook', as: :api_webhooks_sparkpost
      post :mailgun, to: 'webhooks#mailgun_webhook', as: :api_webhooks_mailgun
      post :aws, to: 'webhooks#aws_webhook', as: :api_webhooks_aws
    end
  end

  root :to => 'application#index'
end
