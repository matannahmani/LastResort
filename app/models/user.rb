class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :generate_random_resource
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_resources
  has_many :cache_resources
  has_many :user_units
  has_many :user_structures
  validates :nickname, uniqueness: true

  def generate_random_resource
    radius = ENV['CACHE_RESOURCE_RANDOM_RADIUS'].to_f
    resource_count = 100 * radius
    center = ENV['CACHE_RESOURCE_RANDOM_CENTER']
    resource_count.to_i.times do
      random_resource = Resource.order(Arel.sql('RANDOM()')).first
      random_amount = rand(1..100)
      location = Geocoder::Calculations.random_point_near(center, radius)
      CacheResource.create!(
        longitude: location[1],
        latitude: location[0],
        amount: random_amount,
        resource: random_resource,
        user: self
      )
    end
  end
end
