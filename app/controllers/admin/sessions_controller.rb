class Admin::SessionsController < Admin::ApplicationController

  skip_before_action :require_admin!

  def new

  end

  def create
    admin = Administrator.where('name = ?', params[:session][:username]).first
    puts "====================================================================="
    if admin && admin.authenticate(params[:session][:password])
      puts "------------------------------------------------------------------"
      session[:admin_id] = admin.id
      puts "#{session[:admin_id]}================================"
      redirect_to admin_root_path
    else
      flash.now[:alert] = 'Invalid login credentials.'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    reset_session
    redirect_to root_path
  end

end