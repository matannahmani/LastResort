class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :generate_random_resource, :generate_user_structures, :generate_user_resources
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

  def generate_user_structures
    structure_types = Structure.all
    structure_types.each do |type|
      UserStructure.create!(
        amount: 0,
        user: self,
        structure: type
        )
    end
  end

  def generate_user_resources
    resources_types = Resource.all
    resources_types.each do |type|
      UserResource.create!(
        amount: 100,
        resource: type,
        user: self
        )
    end
  end

  def resources_by_name(name)
    user_resources.joins(:resource).where('resources.name = ?', name)
  end

  def resources_amounts
    {
      wood: resources_by_name('wood').first.amount,
      water: resources_by_name('water').first.amount,
      iron: resources_by_name('iron').first.amount,
      gold: resources_by_name('gold').first.amount
    }
  end
end
