class Contact::Email < Contact
  def validate_value
    self.status = :invalid if ValidatesEmailFormatOf::validate_email_format(value, :check_mx => true)
  end
end
