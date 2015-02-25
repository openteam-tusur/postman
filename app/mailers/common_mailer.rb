class CommonMailer < ActionMailer::Base
  before_filter :add_inline_attachment!

  layout 'email'

  private

  def add_inline_attachment!
    attachments.inline['logo_w.png'] = { :content => File.read(Rails.root.join('app/assets/images/logo_w.png')), :content_id => "<logo_w.png@#{Settings['app.host']}>" }
  end
end
