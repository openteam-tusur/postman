module ApplicationHelper
  def document_title
    [page_title, I18n.t('site')].compact.join(' / ')
  end

  def page_title(title = nil)
    @page_title ||= I18n.t("page_title.#{controller_name}.#{action_name}", title: title).html_safe
  end

  def delivery_status(message, contact)
    message.contact_messages.find_by(contact_id: contact.id).status
  end

  def message_contacts_status(message)
    contact_messages = message.contact_messages
    good = contact_messages.map(&:good?).reject{|bool| !bool}
    status = contact_messages.size == good.size ? 'success' : 'danger'
    if contact_messages.size > 1
      content_tag :span, "#{good.size}/#{contact_messages.size}", class: "label label-#{status} pull-right"
    else
      content_tag :span, status == 'success' ? "Доставлено" : "Не доставлено", class: "label label-#{status} pull-right"
    end
  end
end
