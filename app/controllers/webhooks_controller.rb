require 'openssl'

class WebhooksController < ActionController::Base

  def catch_hook
    render nothing: true, status: 403 and return unless params[:token] == Settings['webhooks.sparkpost.token']
    SparkPostWebhook.new(params).perform

    render nothing: true and return
  end

  def mailgun_webhook
    api_key = Settings['mailgun.api_key']
    token = params['token']
    timestamp = params['timestamp']
    signature = params['signature']

    if verify_mailgun(api_key, token, timestamp, signature)
      MailgunWebhook.new(params).perform
      render json: {
        status: 200,
        message: 'OK'
      }
    else
      render json: {
        status: 403,
        message: 'Forbidden'
      }, status: 403
    end
  end

  def aws_webhook
    ap aws_hash
    logger.info aws_hash
    MailgunWebhook.new(params).perform
    render nothing: true and return
  end

  private

  def verify_mailgun(api_key, token, timestamp, signature)
    digest = OpenSSL::Digest::SHA256.new
    data = [timestamp, token].join
    signature == OpenSSL::HMAC.hexdigest(digest, api_key, data)
  end

  def aws_hash
    @aws_hash ||= Hashie::Mash.new(
      aws_json.transform_keys{ |key| key.underscore }
    )
  end

  def aws_json
    JSON.load(request.raw_post) rescue {}
  end
end
