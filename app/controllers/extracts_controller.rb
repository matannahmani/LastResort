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
      render json: current_user.cache_resources.where(extracted: false)
    end
  end

  def extract_item(lat, lng)
    resources = current_user.cache_resources
    checked_resources = resources.map do |resource|
      distance = Geocoder::Calculations.distance_between([lat,lng], [resource.latitude, resource.longitude], options = { unit: :km} )
      if distance <= 0.75 # Needs to changed to smaller distance when SSL works
        resource.update(extracted: true)
        # render json: {msg:resource.extracted}
      end
    end
  end
end
