class Api < Grape::API
  format :json
  prefix :api

  get :ping do
    'pong'
  end

  namespace ":send" do
    params do
      requires :body,    :type => String
      requires :subject, :type => String
      requires :emails,  :type => Array
    end
    post :mail do
      MailWorker.perform_async params[:subject], params[:body], params[:emails]
      'Message received'
    end

    params do
      requires :body,    :type => String
      requires :phones,  :type => Array
    end
    post :sms do
      SmsWorker.perform_async params[:body], params[:phones]
      'Message received'
    end
  end
end
