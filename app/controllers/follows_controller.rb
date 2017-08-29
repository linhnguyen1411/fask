class FollowsController < ApplicationController
  include UsersHelper

  def update
    if user_signed_in? && params[:id].present?
      if check_follow params[:id]
        @data = Settings.relationships.unfollow
        User.unfollow(current_user, params[:id])
      else
        @data = Settings.relationships.follow
        User.follow(current_user, params[:id])
      end
      result = {type: Settings.success, relationships: @data}
    else
      result = {type: Settings.error}
    end
    respond_to do |format|
      format.json do
        render json: result
      end
    end
  end
end
