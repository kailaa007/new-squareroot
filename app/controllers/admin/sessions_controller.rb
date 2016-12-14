class Admin::SessionsController < Admin::ApplicationController

  skip_before_action :require_admin!

  def new
  end

  def create
    admin = Administrator.where('LOWER(email) = ?', params[:session][:email].downcase).first
    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id
      redirect_to admin_root_path
    else
      flash.now[:alert] = 'Invalid login credentials.'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end