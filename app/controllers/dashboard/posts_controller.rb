class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = current_user.posts.newest.page(params[:page_post]).per Settings.paginate_default
    @clips_posts = Post.list_posts_clip(current_user.clips.pluck(:post_id))
      .page(params[:page_clips_post]).per Settings.paginate_default
    @improvements = AVersion.get_all_post_version_of_user(current_user.id, "Post").newest
      .page(params[:page_improvement]).per Settings.paginate_default
    @active_tab = params[:active_tab]
  end
end
