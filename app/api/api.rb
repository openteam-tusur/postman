class Api < Grape::API
  format :json
  prefix :api

  get :ping do
    'pong'
  end

  namespace :send do
    params do
      requires :body,    :type => String
      requires :subject, :type => String
      requires :emails,  :type => Array
      requires :slug,    :type => Array, :values => -> { Property::Email.pluck(:slug).uniq }
    end
    post :mail do
      MailWorker.perform_async params[:subject], params[:body], params[:emails], params[:slug]
      'Message received'
    end

    params do
      requires :body,    :type => String
      requires :phones,  :type => Array
      requires :slug,    :type => String, :values => -> { Property::Sms.pluck(:slug).uniq }
    end
    post :sms do
      SmsWorker.perform_async params[:body], params[:phones], params[:slug]
      'Message received'
    end
  end

  namespace :webhooks do
    get :ping do
      'pong'
    end

    params do
      requires :token,   :type => String, :values => [Settings['webhooks.sms.token']]
    end
    post :sms do
      puts params[:data]
      SmsWebhook.new(params[:data]).perform
      '100'
    end

    params do
      requires :token, :type => String, :values => [Settings['webhooks.mandrill.token']]
    end
    post :mandrill do
      MandrillWebhook.new(params[:mandrill_events]).perform
    end
  end
end
