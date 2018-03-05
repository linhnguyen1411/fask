class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include PublicActivity::StoreController

  before_action :load_notification
  before_action :set_locale
  before_action :load_topics

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json {render json: {type: false, not_authorized: true}}
      format.html {redirect_to root_url, notice: exception.message}
      format.js {render template: "shared/authorization_error.js.erb"}
    end
  end

  def after_sign_in_path_for resource
    if @admin.present?
      rails_admin_path
    else
      session[:before_login_url] || topic_path(Settings.topic.feedback_number)
    end
  end

  def after_sign_out_path_for(resource)
    (resource == :admin) ? new_admin_session_path : root_path
  end

  def authenticate_user
    return if user_signed_in?
    if request.get?
      session[:before_login_url] = request.original_url
    else
      session[:before_login_url] = request.referer
    end
    respond_to do |format|
      format.html {redirect_to new_user_session_path}
      format.json {render json: {type: false, not_login: true}}
      format.js {render :template  => "shared/sign_in.js.erb"}
    end
  end

  def see_notification
    if user_signed_in? && params[:noti_id].present?
      notification = Notification.find_by id: params[:noti_id]
      if notification.present? && notification.user_id == current_user.id && notification.not_seen?
        notification.update_attributes status: :seen
      end
    end
  end

  private

  def load_notification
    if user_signed_in? && @current_user.try(:id) != Settings.anonymous_number
      @list_notifications = current_user.notifications.includes_activity.by_date
    end
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def load_topics
    @topics = Topic.all
  end
end
