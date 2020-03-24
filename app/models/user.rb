class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_initialize :init
  after_create :generate_random_resource, :generate_user_structures, :generate_user_resources
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_resources
  has_many :cache_resources
  has_many :user_units
  has_many :user_structures
  validates :nickname, uniqueness: true
  has_one_attached :photo
  has_many :sender,  :class_name => 'Transaction', :foreign_key => 'sender_id'
  has_many :receiver,  :class_name => 'Transaction', :foreign_key => 'receiver_id'

  def generate_random_resource(location=[1.1,1.1])
    if location != nil
      mycache = CacheResource.where(user_id: self)
      gennewbool = true
      mycache.each do |loc|
        distance = Geocoder::Calculations.distance_between([location[0],location[1]], [loc.latitude, loc.longitude], options = { unit: :km} )
        # binding.pry
        if distance <= 0.15
          gennewbool = false
        end
      end
      if gennewbool == true
        mycache.destroy_all
          radius = ENV['CACHE_RESOURCE_RANDOM_RADIUS'].to_f
          resource_count = 80 * radius
          center = location
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
        else
          render json: {response: 500}
        end
      end
  end

  def init
    self.raidcount  ||= 0           #will set the default value only if it's nil
    self.xp = 0
    self.imgupdate = true if self.imgupdate.nil?
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

  def xptolevel
    return Level.find_by(xp: self.xp+1..Level.last.xp)
  end

  def protected
    return [self.xp,self.nickname,self.xptolevel]
  end
end
