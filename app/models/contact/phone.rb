class Contact::Phone < Contact
  def validate_value
    self.status = :invalid unless value =~ /\A\d{10}\z/
  end
end
