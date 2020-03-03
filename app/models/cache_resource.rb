class CacheResource < ApplicationRecord
  belongs_to :resource
  belongs_to :user
  validates :latitude, presence: true
  validates :longitude, presence: true
  after_create :add_picture

  def add_picture
    if self.resource.name == "wood"
      # binding.pry
        self.image_url = ActionController::Base.helpers.asset_url("log-2.png")
        self.save
      elsif self.resource.name == "water"
        self.image_url = ActionController::Base.helpers.asset_url("water-2.png")
        self.save
      elsif self.resource.name == "iron"
        self.image_url = ActionController::Base.helpers.asset_url("metal-2.png")
        self.save
      elsif self.resource.name == "gold"
        self.image_url = ActionController::Base.helpers.asset_url("gold.png")
        self.save
      end
  end
end
