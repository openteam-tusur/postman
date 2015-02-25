require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount Api => '/'

  resources :messages, :only => [:index, :show]
  root :to => 'application#index'
end
