class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @activities = User.get_activities(current_user).page(params[:page]).
      per Settings.activities.items_per_page
  end
end
