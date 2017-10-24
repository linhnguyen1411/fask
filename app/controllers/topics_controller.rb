class TopicsController < ApplicationController
  before_action :authenticate_user

  def show
    @support = Supports::PostSupport.new Post, params[:id], params[:type], params[:all], params[:page]
  end
end
