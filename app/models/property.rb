class Property < ActiveRecord::Base
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug, scope: :type
end

# == Schema Information
#
# Table name: properties
#
#  id         :integer          not null, primary key
#  title      :string
#  type       :string
#  url        :text
#  footer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  email      :string
#
