class TopicsController < ApplicationController
  def show
    if params[:all]
      @posts = Post.newest.get_post_by_topic(params[:id]).page params[:page]
    else
      @posts = Post.newest.get_post_by_topic(params[:id]).limit(Settings.paginate_default)
    end
  end
end
