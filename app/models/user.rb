class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.host']
  end
end
