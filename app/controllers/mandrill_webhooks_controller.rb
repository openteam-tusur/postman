class MandrillWebhooksController < ActionController::Base
  before_filter :find_mandrill_response, :find_contact_message

  def sent
    if @contact_message
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :received)
    end

    render :nothing => true
  end

  def bounced
    if @contact_message
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :failed)
    end

    render :nothing => true
  end

  def opened
    if @contact_message
      @contact_message.update_attributes!(:raw_email_status => @mandrill_response, :status => :delivered)
    end

    render :nothing => true
  end

  private

  def find_mandrill_response
    @mandrill_response = JSON.parse(params[:mandrill_events]).first rescue {}
  end

  def find_contact_message
    contact_message_id = @mandrill_response.try(:[], 'msg').try(:[], 'metadata').try(:[], 'contact_message_id')

    @contact_message = ContactMessage.find_by(:id => contact_message_id)
  end
end
