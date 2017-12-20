class Permission < ActiveRecord::Base
  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:administrator]
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :string
#  context_id   :integer
#  context_type :string
#  role         :string
#  created_at   :datetime
#  updated_at   :datetime
#
