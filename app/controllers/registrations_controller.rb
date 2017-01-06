class RegistrationsController < Devise::RegistrationsController
 
  def new
    @user = User.new
  end

  def create
    super
  end

  def update
    super
  end

  
  protected

  def after_update_path_for(resource)
    edit_profile_path
  end

  def after_sign_up_path_for(resource)
    birth_plans_path
  end

  def after_inactive_sign_up_path_for(resource)
    birth_plans_path
  end
end
