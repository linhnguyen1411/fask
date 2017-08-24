module ApplicationHelper
  def image_tag source, options={}
    source = "no_avatar" if source.blank?
    super source, options
  end

  def show_activities activity
    case activity.trackable_type
      when "Post"
        render "devise/registrations/activity_post", post: activity.trackable, activity: activity
      when "Answer"
        t ".activities.answered"
        render "devise/registrations/activity_reaction", post: activity.trackable.post, activity: activity
      when "Comment"
        t ".activities.commented"
        render "devise/registrations/activity_reaction", post: activity.trackable.commentable, activity: activity
      when "Clip"
        t ".activities.cliped"
        render "devise/registrations/activity_reaction", post: activity.trackable.post, activity: activity
    end
  end
end
