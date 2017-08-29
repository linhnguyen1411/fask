class StaticPagesController < ApplicationController
  def index
    if params[:tag_id].nil?
      @posts = Post.page(params[:page]).per Settings.paginate_default
    else
      @posts = Post.by_tags(params[:tag_id]).page(params[:page])
        .per Settings.paginate_default
    end
    @topUsers = User.top_users.limit Settings.limit_top
    @recentComments = Comment.order("id desc").limit Settings.limit_top
    @tags = Tag.top_tags.limit Settings.limit_tag
  end
end
