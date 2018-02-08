class FollowsController < ApplicationController
  include UsersHelper
  before_action :authenticate_user
  authorize_resource :relationship, parent: false

  def update
    if params[:id].present?
      if check_follow params[:id]
        @data = Settings.relationships.unfollow
        User.unfollow(current_user, params[:id])
      else
        @data = Settings.relationships.follow
        User.follow(current_user, params[:id])
      end
      result = {type: true, relationships: @data}
    else
      result = {type: false}
    end
    respond_to do |format|
      format.json do
        render json: result
      end
    end
  end
end
