module ApplicationHelper
  def document_title
    [page_title, I18n.t('site')].compact.join(' / ')
  end

  def page_title(title = nil)
    @page_title ||= I18n.t("page_title.#{controller_name}.#{action_name}", :title => title).html_safe
  end

  def delivery_status(message, contact)
    message.contact_messages.find_by(:contact_id => contact.id).status
  end
end
