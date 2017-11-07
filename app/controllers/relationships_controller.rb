class RelationshipsController < ApplicationController
  before_action :authenticate_user

  def index
    if params[:relationship] == Settings.following
      @title = t "profile.following.title"
      @users = current_user.following.page(params[:page]).per Settings.paginate_users
    else
      @title = t "profile.followers.title"
      @users = current_user.followers.page(params[:page]).per Settings.paginate_users
    end
    render "users/index"
  end
end
