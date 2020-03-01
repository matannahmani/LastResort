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
    @unextracted_resources = current_user.cache_resources.where(extracted: false) if !current_user.nil?
    @cache_resources = @unextracted_resources.map do |resource|
        if resource.resource.name == "wood"
          image = #path
        elsif resource.resource.name == "water"
          image = #path
        elsif resource.resource.name == "iron"
          image = #path
        elsif resource.resource.name == "gold"
          image = #path
        end

        {
          lat: resource.latitude,
          lng: resource.longitude,
          infoWindow: render_to_string(partial: "infowindow", locals: { cache_resource: resource }),
          image_url: helpers.asset_url(image)
        }
    end
    @cache_resources = current_user.cache_resources.where(extracted: false) if !current_user.nil? && !current_user.cache_resources.empty?
  end
end
