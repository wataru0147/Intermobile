class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 	before_action :authenticate_user!, except: [:root_path]

	def authenticate_admin!
		if current_user.role.name == "admin"
		else
			redirect_to root_path, :notice => "You are not authorized to access the page"
		end
	end

  def authenticate_staff!
    if current_user.role.name == "admin"
    else
      redirect_to root_path, :notice => "You are not authorized to access the page"
    end
  end
 	
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :contact_number
    devise_parameter_sanitizer.for(:account_update) << :contact_number
    devise_parameter_sanitizer.for(:sign_up) << :contact_number_prefix
    devise_parameter_sanitizer.for(:account_update) << :contact_number_prefix
  end
end
