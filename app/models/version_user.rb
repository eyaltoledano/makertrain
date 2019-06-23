class VersionUser < ApplicationRecord
  belongs_to :user
  belongs_to :version
end
