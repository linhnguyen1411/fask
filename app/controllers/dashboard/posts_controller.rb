class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @supports = Supports::Dashboard::PostSupport.new(current_user, post_params.to_h)
  end

  private

  def post_params
    params.permit :page_post, :page_clips_post, :page_improvement, :active_tab
  end
end
