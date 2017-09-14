class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PublicActivity::StoreController

  before_action :load_notification

  def after_sign_in_path_for resource
    session[:before_login_url] if session[:before_login_url].present?
  end

  private

  def load_notification
    if user_signed_in?
      @notifications = current_user.notifications.by_date
    end
  end
end
