class Property < ActiveRecord::Base
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug, :scope => :type
end
