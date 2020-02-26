class Unit < ApplicationRecord
  has_many :user_units
  validates :name, presence: true, uniqueness: true
  validates :attack, presence: true
  validates :defense, presence: true
  validates :rarity, presence: true
  validates :range, presence: true
  validates :hp, presence: true
  validates :speciality, presence: true
end
