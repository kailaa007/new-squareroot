class Admin::AdministratorsController < Admin::ApplicationController

  before_action :get_admin, only: [ :edit, :update, :destroy ]

  def new
    @administrator = Administrator.new
  end

  def create
    @administrator = Administrator.new(admin_params)
    if @administrator.save
      flash[:success] = 'Administrator created successfully.'
      redirect_to admin_administrators_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @administrator.update(admin_params)
      flash[:success] = 'Administrator updated.'
      redirect_to admin_administrators_path
    else
      render :edit
    end
  end

  def destroy
    @administrator.destroy
    flash[:success] = 'Administrator destroyed.'
    redirect_to admin_administrators_path
  end

  def index
    @administrators = Administrator.order('name asc')
    puts "#{@administrators.inspect}"
  end




  def get_admin
    @administrator = Administrator.find(params[:id])
  end

  def admin_params
    params.require(:administrator).permit(:name, :email, :password, :password_confirmation, :resent_sent_at, :reset_token)
  end

end