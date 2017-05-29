class TagsController < ApplicationController

  def show
    @tag   = Tag.find(params[:id])
    @posts = @tag.news.order('post_date desc')
    render 'news/index'
  end

end