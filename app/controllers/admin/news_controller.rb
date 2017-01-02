class Admin::NewsController < Admin::ApplicationController

  before_action :get_news, only: [ :edit, :update, :destroy ]

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      flash[:success] = 'News created successfully.'
      redirect_to admin_news_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      flash[:success] = 'News updated.'
      redirect_to admin_news_index_path
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    flash[:success] = 'News destroyed.'
    redirect_to admin_news_index_path
  end

  def index
    @news = News.order('title asc').paginate(:page => params[:page])
     puts "#{session[:admin_id]}================================"
  end


  private

  def get_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :excerpt, :link, :post_date, :tag_id, :author)
  end

end

