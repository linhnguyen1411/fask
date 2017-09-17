class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PublicActivity::StoreController

  before_action :load_notification
  before_action :set_locale

  def after_sign_in_path_for resource
    session[:before_login_url] if session[:before_login_url].present?
  end

  private

  def load_notification
    if user_signed_in?
      if params[:noti_id].present?
        notification = Notification.find_by id: params[:noti_id]
        if notification.present? && notification.user_id == current_user.id && notification.no_seen?
          notification.update_attributes status: :seen
        end
      end
      @list_notifications = current_user.notifications.by_date.limit Settings.limit_notification
    end
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
