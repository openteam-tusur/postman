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
      requires :slug,    :type => String, :values => -> { Property::Email.pluck(:slug).uniq }
    end
    post :mail do
      emails_with_uuid = params[:emails].inject({}) { |h, email| h[email.downcase] = SecureRandom.uuid if email.presence; h }

      MailWorker.perform_async params[:subject], params[:body], emails_with_uuid, params[:slug]

      emails_with_uuid
    end

    params do
      requires :body,    :type => String
      requires :phones,  :type => Array
      requires :slug,    :type => String, :values => -> { Property::Sms.pluck(:slug).uniq }
    end
    post :sms do
      phones_with_uuid = params[:phones].inject({}) { |h, phone| h[phone] = SecureRandom.uuid if phone.presence; h }

      SmsWorker.perform_async params[:body], phones_with_uuid, params[:slug]

      phones_with_uuid
    end
  end

  namespace :webhooks do
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

  namespace :status do
    params do
      requires :emails, :type => Array
    end
    post :emails do
      params[:emails].inject({}) { |h, email| h[email] = Contact::Email.find_by(:value => email.downcase).try(:status) || :unknown; h }
    end

    params do
      requires :mails, :type => Array
    end
    post :mails do
      params[:mails].inject({}) { |h, mail_uid| h[mail_uid] = ContactMessage.find_by(:uuid => mail_uid).try(:status) || :unknown; h }
    end

    params do
      requires :phones, :type => Array
    end
    post :phones do
      params[:phones].inject({}) { |h, phone| h[phone] = Contact::Phone.find_by(:value => phone).try(:status) || :unknown; h }
    end

    params do
      requires :smses, :type => Array
    end
    post :smses do
      params[:smses].inject({}) { |h, sms_uid| h[sms_uid] = ContactMessage.find_by(:uuid => sms_uid).try(:status) || :unknown; h }
    end
  end
end
