class ActivitiesController < ApplicationController
  def index
    @activities = User.get_activities(current_user).page(params[:page]).
      per Settings.activities.items_per_page
  end
end
