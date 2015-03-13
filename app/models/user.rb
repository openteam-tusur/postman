class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name']
  end

  def administrator?
    permissions.where(:role => :administrator).any?
  end
end
