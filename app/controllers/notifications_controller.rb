class NotificationsController < ApplicationController
  before_action :authenticate_user
  authorize_resource

  def index
    @notifications = current_user.notifications.by_date.page(params[:page]).per Settings.paginate_default
  end

  def update
    success = false
    if user_signed_in?
      @notifications = current_user.notifications.not_seen
      if @notifications.update_all status: :seen
        success = true
      end
    end
    respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
  end
end
