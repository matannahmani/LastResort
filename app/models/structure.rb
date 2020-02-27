class Structure < ApplicationRecord
  validates :unit_name, presence: true
  validates :wood, presence: true
  validates :iron, presence: true
  validates :gold, presence: true
  validates :hp, presence: true
  validates :range, presence: true
end
