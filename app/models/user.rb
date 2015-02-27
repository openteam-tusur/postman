class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.host']
  end

  def administrator?
    permissions.where(:role => :administrator).any?
  end
end
