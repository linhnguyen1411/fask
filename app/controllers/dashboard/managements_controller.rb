class Dashboard::ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_user

  def index
  end

  private
  def check_admin_user
    return if User.position_admin.include?(current_user)
    flash[:danger] = t "feedback.error"
    redirect_to root_path
  end
end
