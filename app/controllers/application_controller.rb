class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  include PublicActivity::StoreController

  before_action :load_notification
  before_action :set_locale

  def after_sign_in_path_for resource
    session[:before_login_url] if session[:before_login_url].present?
  end

  def authenticate_user
    return if user_signed_in?
    respond_to do |format|
      format.html {redirect_to new_user_session_path}
      format.json {render json: {type: false, not_login: true}}
      format.js {render :template  => "shared/sign_in.js.erb"}
    end
  end

  private

  def load_notification
    if user_signed_in?
      if params[:noti_id].present?
        notification = Notification.find_by id: params[:noti_id]
        if notification.present? && notification.user_id == current_user.id && notification.not_seen?
          notification.update_attributes status: :seen
        end
      end
      @list_notifications = current_user.notifications.by_date
    end
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
