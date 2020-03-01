class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache_resources
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def set_cache_resources
    @cache_resources = current_user.cache_resources.where(extracted: false) if !current_user.nil?
    # @cache_resources.map do |resource|
    #   if resource.resource.name == "wood"
    #      resource.image_url = helpers.asset_url("log-2.png")
    #   elsif resource.resource.name == "water"
    #     resource.image_url = helpers.asset_url("water-2.png")
    #   elsif resource.resource.name == "iron"
    #     resource.image_url = helpers.asset_url("metal-2.png")
    #   elsif resource.resource.name == "gold"
    #     resource.image_url = helpers.asset_url("gold.png")
    #   end

    #     # {
    #     #   lat: resource.latitude,
    #     #   lng: resource.longitude,
    #     #   infoWindow: render_to_string(partial: "infowindow", locals: { cache_resource: resource }),
    #     #   image_url: helpers.asset_url(image)
    #     # }
    # end
    # binding.pry
    # @cache_resources = current_user.cache_resources.where(extracted: false) if !current_user.nil? && !current_user.cache_resources.empty?
  end
end
