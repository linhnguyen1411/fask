class UsersController < ApplicationController
  before_action :authenticate_user
  authorize_resource
  before_action :load_user, only: [:show, :update]
  before_action :see_notification, only: :show

  def index
    @title = t "profile.index.title"
    @users = User.page(params[:page])
      .get_users_not_contain_id([current_user.id, Settings.id_user_hiddent])
      .per Settings.paginate_users
  end

  def show
    @user_support = Supports::UserSupport.new @user
  end

  def update
    success = false
    if @user.valid_password? params[:current_password]
      if @user.update_attributes password: params[:new_password]
        mess = t "profile.update_password.success"
        success = true
      else
        mess =  t "profile.update_password.error"
      end
    else
      mess = t "profile.update_password.current_password_wrong"
    end
    respond_to do |format|
      format.json do
        render json: {type: success, mess: mess}
      end
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
