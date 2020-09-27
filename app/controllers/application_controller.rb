class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    main_team_path(current_user.team_id)
  end 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def if_not_admin
    redirect_to main_team_path(current_user.team_id) unless current_user.admin?
  end

  def authenticate
    redirect_to root_path unless user_signed_in?
  end

end
