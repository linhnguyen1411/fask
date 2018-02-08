class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  after_create :send_notification

  scope :by_date, -> {order created_at: :desc}

  scope :includes_activity, -> { includes(:activity, :user) }
  enum status: {not_seen: 0, seen: 1}

  def load_message
    return false if self.activity.nil?
    activity = self.activity
    case activity.trackable.class.name
    when Post.name
      post = activity.trackable
      if self.is_tag_user?
        @message = I18n.t("noti.tag_post") + " \"#{post.title}\""
      elsif self.activity.parameters[:status_changed] == "accept"
        @message = I18n.t("posts.status.feedback_info")
      elsif self.activity.parameters[:status_changed] == "reject"
        @message = I18n.t("posts.status.feedback_reject")
      else
        @message = I18n.t("noti.create_post") + " \"#{post.title}\"" + I18n.t("noti.in_topic") + "#{post.topic.name}"
      end
    when Answer.name
      if self.is_tag_user?
        post = activity.trackable.post
        @message = I18n.t("noti.tag_answer") + " \"#{post.title}\""
      else
        post = activity.trackable.post
        @message = I18n.t("noti.answer_post") + " \"#{post.title}\""
      end
    when Comment.name
      if activity.trackable.commentable.class.name == Post.name
        post = activity.trackable.commentable
        if self.is_tag_user?
          @message = I18n.t("noti.tag_comment") + " \"#{post.title}\""
        else
          @message = I18n.t("noti.comment_post") + " \"#{post.title}\""
        end
      else
        post = activity.trackable.commentable.post
        if self.is_tag_user?
          @message = I18n.t("noti.tag_comment") + " \"#{post.title}\""
        else
          @message = I18n.t("noti.comment_answer") + I18n.t("noti.in_post") + " \"#{post.title}\""
        end
      end
    when Reaction.name
      object = activity.trackable.reactiontable
      case object.class.name
      when Post.name
        post = object
        item = I18n.t("noti.your_post") + " \"#{post.title}\""
      when Answer.name
        post = object.post
        item = I18n.t("noti.your_answer") + I18n.t("noti.in_post") + " \"#{post.title}\""
      else #Comment
        if object.commentable.class.name == Post.name
          post = object.commentable
        else
          post = object.commentable.post
        end
        item = I18n.t("noti.your_comment") + I18n.t("noti.in_post") + " \"#{post.title}\""
      end
      @message = I18n.t("noti.have") + I18n.t("noti.#{activity.trackable.target_type.to_s}")  + item
    when Clip.name
      post = activity.trackable.post
      @message = I18n.t("noti.clip_post") + " \"#{post.title}\""
    when AVersion.name
      post = activity.trackable.a_versionable
      if post.user_id == activity.owner_id && activity.trackable.status != Settings.version.improve
        @message = " " + activity.trackable.status + I18n.t("version.your_improvement")
      else
        @message = I18n.t("noti.suggested_changes") + " \"#{post.title}\""
      end
    when Relationship.name
      user = activity.recipient
      @message = I18n.t("noti.follow_user")
    end
    id = post.present? ? post.id : user.id
    [@message, id]
  end

  private

  def send_notification
    NotificationBroadcastJob.perform_now self
  end
end
