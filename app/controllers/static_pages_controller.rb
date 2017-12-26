class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      @home_page = true
      if params[:tag_id].nil?
        @posts = Post.page(params[:page]).newest.accept.per Settings.paginate_default
      else
        @posts = Post.by_tags(params[:tag_id]).newest.accept.page(params[:page])
          .per Settings.paginate_default
      end
      @topUsers = User.top_users.limit Settings.limit_top
      @recentComments = Comment.order("id desc").limit Settings.limit_top
      @tags = Tag.top_tags.limit Settings.limit_tag
    else
      redirect_to new_user_session_path
    end
  end
end
