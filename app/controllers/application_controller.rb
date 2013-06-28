class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User) && resource.admin?
        admin_relationships_path
      else
        super
      end
  end

  def get_referer_params(key)
    referer_params = Rack::Utils.parse_query URI(request.referer).query
    referer_params[key]
  end

  private
  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

end
