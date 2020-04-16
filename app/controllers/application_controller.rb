class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cache_resources
  before_action :detect_device_variant
  rescue_from Exception, :with => :render_404
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def set_cache_resources
    @cache_resources = current_user.cache_resources.where(extracted: false) if !current_user.nil?
  end

  private

  def detect_device_variant
    render "games/desktop" if !browser.device.mobile?
  end

  def render_404
    render :template => 'pages/404', :layout => false, :status => :not_found
  end

end
