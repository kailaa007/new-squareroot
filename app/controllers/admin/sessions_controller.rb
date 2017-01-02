class Admin::SessionsController < Admin::ApplicationController

  skip_before_action :require_admin!

  def new
    if current_admin.present?
      flash[:success] = 'Already signed in'
      redirect_to admin_root_path
    end  

  end

  def create
    admin = Administrator.where('name = ?', params[:session][:username]).first
    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id
      redirect_to admin_news_index_path
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