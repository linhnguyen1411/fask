class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user
  authorize_resource

  def index
    @supports = Supports::FeedbackSupport.new(current_user, post_params.to_h)
  end

  private

  def post_params
    unless params[:active_tab] == Settings.posts
      redirect_to root_path
    end
    params.permit :page_post, :page_clips_post, :page_improvement, :active_tab
  end
end
