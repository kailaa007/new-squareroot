class Admin::PasswordResetsController < Admin::ApplicationController
  skip_before_action :require_admin!
  
  def new
  end

  def create
    @admin = Administrator.find_by(email: params[:password_resets][:email].downcase)
    if @admin
      @admin.send_password_reset
      flash[:info] = "Email sent with password reset instructions"
      redirect_to admin_login_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  	@admin = Administrator.find_by_reset_token!(params[:id])
  end

	def update
	  @admin = Administrator.find_by_reset_token!(params[:id])
	  if @admin[:resent_sent_at] < 2.hours.ago
	    redirect_to new_admin_password_reset_path, :alert => "Password &crarr; 
	      reset has expired."
	  elsif @admin.update_attributes!(admin_params)
	    redirect_to admin_login_path, :notice => "Password has been reset."
	  else
	    render :edit
	  end
	end

  def admin_params
    params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :resent_sent_at, :reset_token)
  end

end
