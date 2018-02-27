class TopicsController < ApplicationController
  before_action :authenticate_user
  before_action :load_topic
  authorize_resource
  before_action :clear_cache

  def show
    if params[:id] == Settings.topic.feedback
      case
      when params[:from_day].blank? && params[:to_day].blank?
        check_filter_by_week
      when params[:previous_week] && params[:page].blank?
        load_date_ranger_previous
      when params[:next_week]
        load_date_ranger_next
      end
    end
    params[:to_day] = convert_date params[:to_day]
    params[:from_day] = convert_date params[:from_day]
    @support = Supports::TopicSupport.new(topic_params.to_h)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @status = params[:status]
    @topic.update_attributes status: params[:status]
    if @topic.save
      @success = true
    else
      @success = false
    end
    respond_to do |format|
      format.js
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

  def clear_cache
    if request.xhr?
      response.headers['Vary'] = 'Accept'
    end
  end

  def get_nearest_thursday
    current_day = Date.today
    day_of_week = current_day.wday
    case
    when day_of_week == 4
      nearest_thur_day = current_day
    when day_of_week < 4
      nearest_thur_day = current_day - (3 + day_of_week )
    when day_of_week > 4
      nearest_thur_day = current_day - (day_of_week - 4)
    end
    return params[:to_day] = nearest_thur_day
  end

  def check_filter_by_week
    get_nearest_thursday
    params[:from_day] = params[:to_day] - 7
  end

  def load_date_ranger_previous
    params[:to_day] = DateTime.parse params[:from_day]
    params[:from_day] = params[:to_day] - 7
  end

  def load_date_ranger_next
    params[:from_day] = DateTime.parse params[:to_day]
    params[:to_day] = params[:from_day] + 7
  end
end
