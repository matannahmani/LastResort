class Resource < ApplicationRecord
  validates :name, presence: true
  validates :exchange, presence: true
end
