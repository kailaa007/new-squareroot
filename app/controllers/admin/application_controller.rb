class Admin::ApplicationController < ApplicationController

  before_action :require_admin!
  layout 'admin'

  private

  def current_admin
    @current_admin ||= Administrator.find_by_id(session[:admin_id])
  end
  helper_method :current_admin

  def require_admin!
    redirect_to(admin_login_path) unless current_admin
  end

end