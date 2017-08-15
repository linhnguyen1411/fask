class StaticPagesController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per Settings.paginate_default
    @topUsers = User.top_users.limit Settings.limit_top
    @recentComments = Comment.order("id desc").limit Settings.limit_top
  end
end
