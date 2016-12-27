class Admin::TagsController < Admin::ApplicationController

  before_action :get_tag, only: [ :edit, :update, :destroy ]

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag created successfully.'
      redirect_to admin_tags_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:success] = 'Tag updated.'
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = 'Tag destroyed.'
    redirect_to admin_tags_path
  end

  def index
    @tags = Tag.order('name asc').paginate(:page => params[:page])
  end


  private

  def get_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end