class Dashboard::PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @supports = Supports::Dashboard::PostSupport.new(current_user, params[:page_post], params[:page_clips_post],
      params[:page_improvement], params[:active_tab])
  end
end
