class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_current_location, :unless => :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_teacher
    if current_user.is_student?
      flash["error"] = "You don't have permission to access this area"
      return redirect_to dashboard_path
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  private
    # override the devise helper to store the current location so we can
    # redirect to it after loggin in or out. This override makes signing in
    # and signing up work automatically.
    def store_current_location
      store_location_for(:user, request.url)
    end

    # override the devise method for where to go after signing out because theirs
    # always goes to the root path. Because devise uses a session variable and
    # the session is destroyed on log out, we need to use request.referrer
    # root_path is there as a backup
    def after_sign_out_path_for(resource)
      root_path
    end

    def after_sign_in_path_for(resource)
      dashboard_path
    end
end
