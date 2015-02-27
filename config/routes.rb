require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount Api => '/'

  %w(sent bounced opened).each do |event|
    post "/mandrill/webhooks/#{event}" => "mandrill_webhooks##{event}"
  end

  resources :messages, :only => [:index, :show]

  resources :contacts, :only => :show

  namespace :property do
    resources :emails
    resources :smses
  end

  root :to => 'application#index'
end
