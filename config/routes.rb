require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :messages, :only => [:index, :show]

  root :to => 'application#index'
end
