class CacheResource < ApplicationRecord
  belongs_to :resource
  belongs_to :user
  validates :latitude, presence: true
  validates :longitude, presence: true
end
