module ApplicationHelper
  def image_tag source, options={}
    source = "no_avatar" if source.blank?
    super source, options
  end

  def show_activities activity
    case activity.trackable_type
    when AVersion.name
      if activity.trackable.status != Settings.version.waiting
        title = t("version.you_have") + activity.trackable.status + t("version.request")
      else
        title = t("version.change_request")
      end
      icon = '<i class="fa fa-pencil" aria-hidden="true"></i>'
      post = activity.trackable.a_versionable
      content = activity.trackable.content
    when Post.name
      title = t("activities.you") + t("activities.posted")
      icon = '<i class="fa fa-pencil" aria-hidden="true"></i>'
      post = activity.trackable
      content = activity.trackable.content
    when Answer.name
      title = t("activities.you") + t("activities.answered") + t("activities.in_post")
      icon = '<i class="fa fa-comments-o" aria-hidden="true"></i>'
      post = activity.trackable.post
      content = activity.trackable.content
    when Comment.name
      icon = '<i class="fa fa-commenting-o" aria-hidden="true"></i>'
      content = activity.trackable.content
      if activity.trackable.commentable.class.name == Post.name
        title = t("activities.you") + t("activities.commented") + t("activities.in_post")
        post = activity.trackable.commentable
      else
        title = t("activities.you") + t("activities.commented") + t("activities.on_answer")
          + t("activities.in_post")
        post = activity.trackable.commentable.post
      end
    when Reaction.name
      render_reaction activity
      post = @post
      content = activity.trackable.reactiontable.content
      title = @title
      icon = @icon
    when Relationship.name
      render_relationship activity
      title = @title
      icon = @icon
      post = nil
      content = nil
    when Clip.name
      title = t("activities.you") + t("activities.cliped") + t("activities.post")
      icon = '<i class="glyphicon glyphicon-pushpin" aria-hidden="true"></i>'
      post = activity.trackable.post if activity.trackable.present?
      content = nil
    end
    render "activity", post: post, activity: activity,
      title: title, icon: icon, content: content
  end

  def render_reaction activity
    case activity.trackable.target_type
    when Settings.reaction_type.up
      @icon = '<i class="fa fa-plus-square" aria-hidden="true"></i>'
      type = t "activities.upvoted"
    when Settings.reaction_type.down
      @icon = '<i class="fa fa-minus-square" aria-hidden="true"></i>'
      type = t "activities.downvoted"
    when Settings.reaction_type.heart
      @icon = '<i class="fa fa-heartbeat"></i>'
      type = t "activities.loved"
    when Settings.reaction_type.like
      @icon = '<i class="fa fa-thumbs-up"></i>'
      type = t "activities.liked"
    else
      @icon = '<i class="fa fa-thumbs-down"></i>'
      type = t "activities.unliked"
    end
    case activity.trackable.reactiontable.class.name
    when Post.name
      @title = t("activities.you") + type + t("activities.post")
      @post = activity.trackable.reactiontable
    when Answer.name
      @title = t("activities.you") + type + t("activities.answer") + t("activities.in_post")
      @post = activity.trackable.reactiontable.post
    when Comment.name
      @title = t("activities.you") + type + t("activities.comment") + t("activities.in_post")
      if activity.trackable.reactiontable.commentable.class.name == Post.name
        @post = activity.trackable.reactiontable.commentable
      else
        @post = activity.trackable.reactiontable.commentable.post
      end
    end
  end
  def render_relationship activity
    if activity.key == Relationship.name.downcase + "." + Settings.activity.key.unfollow
      type = t "activities.unfollowed"
    else
      type = t "activities.followed"
    end
    @icon = "<i class='fa fa-user'></i>"
    @title = t("activities.you") + type + "<a href=" + user_path(activity.recipient.id) +">" + activity.recipient.name + "</a>"
  end

  def cout_noti
    current_user.notifications.not_seen.size
  end

  def selected_language
     session[:locale]
  end

  def checked_all_notification_setting
    (checked_notification_setting?(Settings.index_zero_in_array) &&
      checked_notification_setting?(Settings.index_one_in_array) &&
      checked_notification_setting?(Settings.index_two_in_array) &&
      checked_notification_setting?(Settings.index_three_in_array) &&
      checked_notification_setting?(Settings.index_four_in_array) &&
      checked_notification_setting?(Settings.index_five_in_array) &&
      checked_notification_setting?(Settings.index_six_in_array) &&
      checked_notification_setting?(Settings.index_seven_in_array) &&
      checked_notification_setting?(Settings.index_eight_in_array) &&
      checked_notification_setting?(Settings.index_nine_in_array)) ? "checked" : ""
  end

  def checked_all_email_setting
    (checked_email_setting?(Settings.index_zero_in_array) &&
      checked_email_setting?(Settings.index_one_in_array) &&
      checked_email_setting?(Settings.index_two_in_array) &&
      checked_email_setting?(Settings.index_three_in_array) &&
      checked_email_setting?(Settings.index_four_in_array) &&
      checked_email_setting?(Settings.index_five_in_array) &&
      checked_email_setting?(Settings.index_six_in_array)) ? "checked" : ""
  end

  def checked_notification_setting? index
    if current_user.notification_settings.present?
      case current_user.notification_settings.values[index]
      when Settings.serialize_false
        return false
      when Settings.serialize_true
        return true
      end
    else
      return true
    end
  end

  def checked_email_setting? index
    if current_user.email_settings.present?
      case current_user.email_settings.values[index]
      when Settings.serialize_false
        return false
      when Settings.serialize_true
        return true
      end
    else
      return true
    end
  end

  def link_notification noti
    if noti.activity.trackable_type == "AVersion"
      "a_versions?post_id=#{noti.load_message.last}"
    else
      post_path(noti.load_message.last, noti_id: noti.id)
    end
  end
end
