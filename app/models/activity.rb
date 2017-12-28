class Activity < PublicActivity::Activity
  belongs_to :trackable, polymorphic: true

  has_many :notifications, dependent: :destroy

  after_create :add_notification
  GET_USER_PATH = /href=\"\/users\/\d{1,}/

  private

  def add_notification
    case self.trackable.class.name
    when Post.name
      notified_users = []
      will_notify_users = if self.parameters[:status_changed].present?
        [self.owner]
      elsif self.trackable.topic_id == Settings.topic.feedback_number
        User.notify_feedback_for_position
      else
        User.all
      end
      if self.trackable.topic_id != Settings.topic.feedback_number || self.parameters[:status_changed] == Settings.version.accept
        notified_users = add_notification_for_tagged_users Settings.notification_setting.tag_post
      end
      will_notify_users.each do |user|
        check_condition_notify notified_users, user, Settings.notification_setting.create_post
      end
    when Answer.name
      notified_users = add_notification_for_tagged_users Settings.notification_setting.tag_post
      check_condition_notify notified_users, self.trackable.post.user, Settings.notification_setting.reply_post
    when Comment.name
      previous_tagged_users = User.previous_tagged_users_in_comment(self.trackable).to_a
      notified_users = add_notification_for_tagged_users Settings.notification_setting.tag_post, previous_tagged_users
      notification_setting = case self.trackable.commentable.class.name
        when Post.name then Settings.notification_setting.comment_post
        when Answer.name then Settings.notification_setting.comment_answer
        end
      check_condition_notify notified_users, self.trackable.commentable.user, notification_setting
    when Reaction.name
      notification_setting = case self.trackable.reactiontable.class.name
        when Answer.name then Settings.notification_setting.llc_answer
        when Comment.name then Settings.notification_setting.like_comment
        when Post.name then Settings.notification_setting.up_down_vote_post
        end
      if check_notification_setting self.trackable.reactiontable.user, notification_setting
        create_notification self.trackable.reactiontable.user_id
      end
    when Clip.name
      if check_notification_setting self.trackable.post.user, Settings.notification_setting.clip_post
        create_notification self.trackable.post.user_id
      end
    when AVersion.name
      create_notification self.trackable.a_versionable.user_id
      create_notification self.trackable.user_id
    when Relationship.name
      create_notification self.recipient.id
    end
  end

  def create_notification user_id, is_feedback = false, is_tag_user = false
    self.notifications.create(user_id: user_id, is_tag_user: is_tag_user) if self.owner_id != user_id || is_feedback
  end

  def add_notification_for_tagged_users notification_setting, notified_users = []
    user_path_array = self.trackable.content.scan GET_USER_PATH
    unless user_path_array.empty?
      user_path_array.uniq.each do |user_path|
        user = User.load_user user_path.slice(Settings.scan_begin_index, user_path.length)
        if user.nil?
          next
        elsif ((!notified_users.include? user) &&
          (user.notification_settings.empty? ||
          user.notification_settings[notification_setting] == Settings.serialize_true))
          notified_users << user
          is_tag_user = true
          is_feedback = false
          create_notification user.id, is_feedback, is_tag_user
        end
      end
    end
    notified_users
  end

  def check_notification_setting user, setting
    user.notification_settings.empty? || user.notification_settings[setting] == Settings.serialize_true
  end

  def check_notified_user notified_users, user
    notified_users.include? user
  end

  def check_condition_notify notified_users, user, setting
    if self.trackable_type == Settings.post.model_name && self.parameters[:status_changed].present?
      is_feedback = true
      create_notification user.id, is_feedback
    elsif !check_notified_user(notified_users, user) && check_notification_setting(user, setting)
      is_feedback = false
      create_notification user.id, is_feedback
    end
  end
end
