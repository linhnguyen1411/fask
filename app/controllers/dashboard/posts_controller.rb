class Dashboard::PostsController < ApplicationController

  def index
    @posts = current_user.posts.page(params[:page]).per Settings.paginate_default
  end
end
