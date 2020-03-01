class ExtractsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def pick_up
    @longitude = params[:longitude]
    @latitude = params[:latitude]
    if !@longitude.nil? && !@latitude.nil?
      cache_resource = extract_item(@latitude, @longitude)
      filtered_resources = current_user.cache_resources.where(extracted: false)
      respond_to do |format|
        format.json  { render json: {pickedResources: cache_resource,
                                        allResources: filtered_resources }}
      end
    else
      # render json: {msg: 'not found'}
    end
  end

  def extract_item(lat, lng)
    resources = current_user.cache_resources.where(extracted: false)
    # binding.pry
    obj = []
    picked_resources = []
    resources.map do |resource|
      distance = Geocoder::Calculations.distance_between([lat,lng], [resource.latitude, resource.longitude], options = { unit: :km} )
      if distance <= 0.1 # Needs to changed to smaller distance when SSL works
        resource.update!(extracted: true)
        add_resource_to_user(resource)
        picked_resources.push(resource)
      else
        # render json: {msg: 'not found'}
      end
    end
    picked_resources.each do |resource|
      obj << {resource_name: Resource.find(resource.resource_id).name, resource: resource}
    end
    obj
  end

  def add_resource_to_user(resource)
    if UserResource.exists?(user_id: current_user.id, resource_id: resource.resource_id)
      user_resources = UserResource.where(user_id: current_user.id, resource_id: resource.resource_id)
      user_resources.each do |user_resource|
        user_resource.update!(amount: (user_resource.amount + resource.amount))
      end
    else
      UserResource.create!(user_id: current_user.id, resource_id: resource.resource_id, amount: resource.amount)
    end
  end
end
