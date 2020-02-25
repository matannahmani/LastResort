class Resource < ApplicationRecord
  has_many :user_resources
  has_many :cache_resources
end
