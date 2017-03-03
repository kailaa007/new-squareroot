class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end 

  def delete
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path
  end  

  def birth_plan_report
    @user = User.find(params[:id])
    @birth_plan_answers = @user.birth_plan_answers
  end  
  
end