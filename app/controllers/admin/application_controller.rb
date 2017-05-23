class Admin::ApplicationController < ApplicationController

  before_action :require_admin!
  layout 'admin'
 
  helper_method :current_admin

  private

  def current_admin
    @current_admin ||= Administrator.find_by_id(session[:admin_id])
  end 

  def require_admin!
    if request["controller"] == "admin/password_resets"
      redirect_to new_admin_password_reset_path
      return
    else
      redirect_to(admin_login_path) unless current_admin
    end  
  end

end