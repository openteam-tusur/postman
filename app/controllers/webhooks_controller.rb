class WebhooksController < ActionController::Base
  before_filter :check_token


  def catch_hook
    SparkPostWebhook.new(params).perform

    render nothing: true and return
  end

  private
  def check_token
    render nothing: true, status: 403 and return unless params[:token] == Settings['webhooks.sparkpost.token']
  end
end
