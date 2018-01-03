class ContactPointsController < ApplicationController
  before_action :check_user, only: :create

  def index
    @contact_points = ContactPoint.all
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def create
    check_user
    if ContactPoint.import(params[:file])
      flash[:success] = t "contact_point.success"
    else
      flash[:danger] = t "contact_point.error_file"
    end
    redirect_to contact_points_path
  end

  private

  def check_user
    return if current_user.position == Settings.event_officer
    flash[:danger] = t "contact_point.not_allowed"
    redirect_to contact_points_path
  end
end
