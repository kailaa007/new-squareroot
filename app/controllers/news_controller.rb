class NewsController < ApplicationController

  def index
    @posts = News.order('post_date desc')
  end

  def show
    @post = News.find(params[:id])
    @post.increment! :visits
    redirect_to @post.link
  end

end