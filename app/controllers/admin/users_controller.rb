class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end 

  def delete
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path
  end  

end