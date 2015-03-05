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
end
