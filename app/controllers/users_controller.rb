class UsersController < ApplicationController
  before_action :load_user, only: :show

  def index
    if user_signed_in?
      @users = User.page(params[:page])
       .get_users_not_contain_id(current_user.id)
       .per Settings.paginate_users
    else
      @users = User.page(params[:page]).per Settings.paginate_users
    end
  end

  def show
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
