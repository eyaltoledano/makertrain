class Product < ApplicationRecord
  belongs_to :user
  has_many :versions
  accepts_nested_attributes_for :versions

  def slug
    self.name.gsub(" ", "-").downcase.gsub(".", "-").gsub("'", "-")
  end

  def self.find_by_slug(slug)
  	self.all.find{ |instance| instance.slug == slug }
  end

  def next_version_number
    "v#{self.versions.count + 1}"
  end

  def latest_version
    self.versions.last
  end

  def latest_version_number
    latest_version.version_number
  end

  def pretty_latest_version_number
    number = self.versions.count
    "Version #{number.to_s}"
  end

  def latest_version_contributors
    latest_version.unique_contributors
  end

  def latest_version_contributor_count
    latest_version_contributors.count
  end

end
