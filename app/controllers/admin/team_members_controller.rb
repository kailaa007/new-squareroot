class Admin::TeamMembersController < Admin::ApplicationController

  before_action :get_team_member, only: [ :edit, :update, :destroy, :show ]

  def new
    @team_member = TeamMember.new
  end

  def create
    @team_member = TeamMember.new(team_member_params)
    if @team_member.save
      flash[:success] = 'Team Member created successfully.'
      redirect_to admin_team_member_path(@team_member)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team_member.update(team_member_params)
      flash[:success] = 'Team Member updated.'
      redirect_to admin_team_member_path(@team_member)
    else
      render :edit
    end
  end

  def destroy
    @team_member.destroy
    flash[:success] = 'Team Member destroyed.'
    redirect_to admin_team_members_path
  end

  def index
    @team_members = TeamMember.order('position asc').paginate(:page => params[:page])
  end

  def show
  end

  def sort
    params[:sort].each do |k, v|
      TeamMember.find(k).update(position: v)
    end
    head :ok
  end


  private

  def get_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit(:name, :title, :bio, :photo, :role, :subtitle)
  end

end

