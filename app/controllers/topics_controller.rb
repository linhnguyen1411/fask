class TopicsController < ApplicationController
  before_action :authenticate_user
  before_action :load_topic

  def show
    @support = Supports::PostSupport.new Post, params[:id], params[:type], params[:all], params[:page], nil, nil, params[:work_space_id]
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def load_topic
    @topic = Topic.find_by id: params[:id]
    return if @topic
    flash[:danger] = t "not_found_topic"
    redirect_to root_path
  end
end
