class Level < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :level, presence: true, uniqueness: true
  validates :xp, presence: true, uniqueness: true
end
