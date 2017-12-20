class Contact::Email < Contact
  def validate_value
    self.status = :invalid if ValidatesEmailFormatOf::validate_email_format(value, check_mx: true)
  end
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  type       :string
#  value      :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
