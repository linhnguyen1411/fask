class TopicsController < ApplicationController
  before_action :authenticate_user
  before_action :load_topic

  def show
    params[:from_day] = convert_date(params[:from_day])
    params[:to_day] = convert_date(params[:to_day])
    @support = Supports::TopicSupport.new(topic_params.to_h)
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
      date.to_date.strftime() if date.present?
    rescue ArgumentError
    end
  end

  def topic_params
    params.permit :from_day, :to_day, :work_space_id, :id, :sort_type,
      :category_id, :page
  end
end
