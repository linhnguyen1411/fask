class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = current_user.posts.newest.page(params[:page]).per Settings.paginate_default
    @clips_posts = Post.list_posts_clip(current_user.clips.pluck(:post_id))
      .page(params[:page]).per Settings.paginate_default
  end
end
