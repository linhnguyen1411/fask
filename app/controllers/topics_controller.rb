class TopicsController < ApplicationController
  before_action :authenticate_user
  before_action :load_topic

  def show
    @support = Supports::PostSupport.new(Post, params[:id], params[:type],
      params[:all], params[:page], nil, nil, params[:work_space_id],
      convert_date(params[:from_day]), convert_date(params[:to_day], true)
    )
    @topUsers = User.top_users.limit Settings.limit_top
    @tags = Tag.top_tags.limit Settings.limit_tag
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

  def convert_date date, is_end_day = false
    begin
      if is_end_day
        (date.to_date + Settings.one_day.days).strftime() if date.present?
      else
        date.to_date.strftime() if date.present?
      end
    rescue ArgumentError
    end
  end
end
