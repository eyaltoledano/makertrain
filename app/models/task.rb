class Task < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product
  belongs_to :version


  def slug
  	self.name.gsub(" ", "-").downcase.gsub(".", "-")
  end

  def self.find_by_slug(slug)
  	self.all.find{ |instance| instance.slug == slug }
  end
end
