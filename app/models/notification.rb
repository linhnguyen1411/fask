class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  after_create :send_notification

  scope :by_date, -> {order created_at: :desc}

  enum status: {not_seen: 0, seen: 1}

  def load_message
    return false if self.activity.nil?
    activity = self.activity
    case activity.trackable.class.name
    when Post.name
      post = activity.trackable
      @message = activity.owner.name + I18n.t("noti.just") + I18n.t("noti.send") + I18n.t("noti.post") + I18n.t("noti.new") + I18n.t("noti.in") + I18n.t("noti.topic") + " #{post.topic.name}"
    when Answer.name
      post = activity.trackable.post
      @message = activity.owner.name + I18n.t("noti.just") + I18n.t("noti.ans") + I18n.t("noti.in") + I18n.t("noti.post") + " #{post.title}"
    when Comment.name
      if activity.trackable.commentable.class.name == Post.name
        post = activity.trackable.commentable
        item = I18n.t("noti.post")
      else
        post = activity.trackable.commentable.post
        item = I18n.t("noti.answer")
      end
      @message = activity.owner.name + I18n.t("noti.just") + I18n.t("noti.comment") + I18n.t("noti.in") + item + I18n.t("noti.of_you")
    when Reaction.name
      object = activity.trackable.reactiontable
      case object.class.name
      when Post.name
        post = object
        item = I18n.t("noti.post")
      when Answer.name
        post = object.post
        item = I18n.t("noti.answer")
      else #Comment
        if object.commentable.class.name == Post.name
          post = object.commentable
        else
          post = object.commentable.post
        end
        item = I18n.t("noti.comment")
      end
      @message = activity.owner.name + I18n.t("noti.just") + I18n.t("noti.#{activity.trackable.target_type.to_s}") + item + I18n.t("noti.of_you")
    end
    [@message, post.id]
  end

  private

  def send_notification
    NotificationBroadcastJob.perform_now self
  end
end
