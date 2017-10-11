class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.page(params[:page]).per Settings.paginate_default
  end
end
