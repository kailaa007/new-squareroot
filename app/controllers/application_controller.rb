class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :zipcode, :due_date, :terms_n_condition])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :zipcode, :due_date])
  end

  def after_sign_in_path_for(resource)
    edit_profile_path
  end

  def after_sign_up_path_for(resource)
  		puts "---------------------------------------------------------------"
    birth_plans_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
  	puts "---------------------------------------------------------------"
        birth_plans_path
  end

  

end