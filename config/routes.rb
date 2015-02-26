require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount Api => '/'

  resources :messages, :only => [:index, :show]
  namespace :property do
    resources :emails
    resources :smses
  end
  root :to => 'application#index'
end
