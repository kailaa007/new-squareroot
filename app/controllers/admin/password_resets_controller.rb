class Admin::PasswordResetsController < Admin::ApplicationController
    skip_before_action :require_admin!
  
  def new
  end

  def edit
  end
end
