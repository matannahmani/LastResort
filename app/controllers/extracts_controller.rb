class ExtractsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def pick_up
    @longitude = params[:longitude]
    @latitude = params[:latitude]
    # raise
    if !@longitude.nil? && !@latitude.nil?
      extract_item(@latitude, @longitude)
      puts "rendering json"
      render json: {user: current_user, msg: "we got it"}
    else
      render json: {msg: 'not found'}
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
    resources = current_user.cache_resources.where(extracted: false)
    # binding.pry
    checked_resources = resources.map do |resource|
      distance = Geocoder::Calculations.distance_between([lat,lng], [resource.latitude, resource.longitude], options = { unit: :km} )
      if distance <= 0.2 # Needs to changed to smaller distance when SSL works
        resource.update(extracted: true)
        puts "Picking up cache resource: "
        p resource
        add_resource_to_user(resource)
        # filtered_resources = current_user.cache_resources.where(extracted: false)
      else
        # render json: {msg: 'not found'}
      end
    end

    # filtered_resources.each do |resource|
    #   {
    #     latitude: resource.latitude
    #     longitude: resource.longitude
    #     user_id: resource.user_id
    #     resource_id: resource.resource_id
    #   }
    # end
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
