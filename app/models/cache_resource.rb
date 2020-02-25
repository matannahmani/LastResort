class CacheResource < ApplicationRecord
  belongs_to :resource
  belongs_to :user
  validates :latitude, presence: true
  validates :longtitude, presence: true
end
