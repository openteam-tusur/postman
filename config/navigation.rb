SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :main_page,      I18n.t("page_title.main_page.index"), root_path
    primary.item :messages,       I18n.t("page_title.messages.index"),  messages_path
    primary.item :email_property, I18n.t("page_title.emails.index"),  property_emails_path
    primary.item :sms_property,   I18n.t("page_title.smses.index"),  property_smses_path
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
