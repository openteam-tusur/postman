class Contact::Phone < Contact
  def validate_value
    self.status = :invalid unless value =~ /\A\d{11}\z/
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
