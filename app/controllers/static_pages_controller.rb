class StaticPagesController < ApplicationController

  def index
    if user_signed_in?
      @home_page = true
      if @topics.load_topic_on.size == Settings.number_one && @topics.load_topic_on.first.name == Settings.feedback
        redirect_to topic_path(2)
      elsif params[:tag_id].nil?
        @posts = Post.post_of_topic_on.page(params[:page]).post_full_includes.newest.accept.per Settings.paginate_default
      else
        @posts = Post.post_of_topic_on.by_tags(params[:tag_id]).post_full_includes.newest.accept.page(params[:page])
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
