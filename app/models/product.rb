class Product < ApplicationRecord
  belongs_to :user
  has_many :versions
  accepts_nested_attributes_for :versions

  def slug
  	self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
  	self.all.find{ |instance| instance.slug == slug }
  end
end
