class Activity < PublicActivity::Activity
  belongs_to :trackable, polymorphic: true

  has_many :notifications, dependent: :destroy

  after_create :add_notification
  GET_USER_PATH = /href=\"\/users\/\d{1,}/

  private

  def add_notification
    case self.trackable.class.name
    when Post.name
      user_path_array = self.trackable.content.scan GET_USER_PATH
      notified_users = []
      unless user_path_array.empty?
        user_path_array.uniq.each do |user_path|
          user = User.load_user(user_path.slice(Settings.scan_begin_index, user_path.length)).first
          if user.nil?
            next
          elsif (user.notification_settings.empty? ||
            user.notification_settings[:tag_post] == Settings.serialize_true)
            notified_users << user
            is_tag_user = true
            create_notification user.id, is_tag_user
          end
        end
      end
      if(self.trackable.topic_id == Settings.topic.feedback_number)
        User.notify_feedback_for_position.each do |user|
          if ((!notified_users.include? user) &&
            (user.notification_settings.empty? || user.notification_settings[:create_post] == Settings.serialize_true))
            create_notification user.id
          end
        end
      else
        User.all.each do |user|
          if ((!notified_users.include? user) &&
            (user.notification_settings.empty? ||
            user.notification_settings[:create_post] == Settings.serialize_true))
            create_notification user.id
          end
        end
      end
    when Answer.name
      user_path_array = self.trackable.content.scan GET_USER_PATH
      notified_users = []
      unless user_path_array.empty?
        user_path_array.uniq.each do |user_path|
          user = User.load_user(user_path.slice(Settings.scan_begin_index, user_path.length)).first
          if user.nil?
            next
          elsif (user.notification_settings.empty? ||
            user.notification_settings[:tag_post] == Settings.serialize_true)
            notified_users << user
            is_tag_user = true
            create_notification user.id, is_tag_user
          end
        end
      end
      if ((!notified_users.include? self.trackable.post.user) &&
        (self.trackable.post.user.notification_settings.empty? ||
        self.trackable.post.user.notification_settings[:reply_post] == Settings.serialize_true))
        create_notification self.trackable.post.user_id
      end
    when Comment.name
      commentable = self.trackable.commentable
      case commentable.class.name
      when Post.name
        if (commentable.user.notification_settings.empty? ||
          commentable.user.notification_settings[:comment_post] == Settings.serialize_true)
          create_notification commentable.user_id
        end
      when Answer.name
        if (commentable.user.notification_settings.empty? ||
          commentable.user.notification_settings[:comment_answer] == Settings.serialize_true)
          create_notification commentable.user_id
        end
      end
    when Reaction.name
      reactiontable = self.trackable.reactiontable
      case reactiontable.class.name
      when Answer.name
        if (reactiontable.user.notification_settings.empty? ||
          reactiontable.user.notification_settings[:llc_answer] == Settings.serialize_true)
          create_notification reactiontable.user_id
        end
      when Comment.name
        if (reactiontable.user.notification_settings.empty? ||
          reactiontable.user.notification_settings[:like_comment] == Settings.serialize_true)
          create_notification reactiontable.user_id
        end
      when Post.name
        if (reactiontable.user.notification_settings.empty? ||
          reactiontable.user.notification_settings[:up_down_vote_post] == Settings.serialize_true)
          create_notification reactiontable.user_id
        end
      end
    when Clip.name
      if (self.trackable.post.user.notification_settings.empty? ||
        self.trackable.post.user.notification_settings[:clip_post] == Settings.serialize_true)
        create_notification self.trackable.post.user_id
      end
    when AVersion.name
      create_notification self.trackable.a_versionable.user_id
      create_notification self.trackable.user_id
    when Relationship.name
      if (self.recipient.notification_settings.empty? ||
        self.recipient.notification_settings[:clip_post] == Settings.serialize_true)
        create_notification self.recipient.id
      end
    end
  end

  def create_notification user_id, is_tag_user = false
    self.notifications.create(user_id: user_id, is_tag_user: is_tag_user) if self.owner_id != user_id
  end
end
