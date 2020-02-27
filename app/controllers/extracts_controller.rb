class ExtractsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def pick_up
    @longitude = params[:longitude]
    @latitude = params[:latitude]
    # raise
    if !@longitude.nil? && !@latitude.nil?
      extract_item(@latitude, @longitude)
    else
      # return json with error
      puts 'failed no cords'
    end
  end

  def index
    if !current_user.nil?
      # binding.pry
      render json: current_user.cache_resources.where(extracted: false)
    end
  end

  def extract_item(lat, lng)
    resources = current_user.cache_resources
    # binding.pry
    checked_resources = resources.map do |resource|
      distance = Geocoder::Calculations.distance_between([lat,lng], [resource.latitude, resource.longitude], options = { unit: :km} )
      if distance <= 0.05 # Needs to changed to smaller distance when SSL works
        resource.update(extracted: true)
        add_resource_to_user(resource)
        # render json: {msg:'found'}
      else
      end
    end
        render json: {msg: 'not found'}
  end

  def add_resource_to_user(resource)
    if UserResource.exists?(user_id: current_user.id, resource_id: resource.resource_id)
      user_resources = UserResource.where(user_id: current_user.id, resource_id: resource.resource_id)
      user_resources.each do |user_resource|
        user_resource.update(amount: (user_resource.amount + resource.amount))
      end
    else
      UserResource.create!(user_id: current_user.id, resource_id: resource.resource_id, amount: resource.amount)
    end
  end
end
