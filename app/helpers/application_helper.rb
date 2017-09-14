module ApplicationHelper
  def image_tag source, options={}
    source = "no_avatar" if source.blank?
    super source, options
  end

  def show_activities activity
    case activity.trackable_type
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
    current_user.notifications.size
  end
end
