class Activity < PublicActivity::Activity
  belongs_to :trackable, polymorphic: true

  has_many :notifications, dependent: :destroy

  after_create :add_notification

  private

  def add_notification
    case self.trackable.class.name
    when Post.name
      if(self.trackable.topic_id == Settings.topic.feedback_number)
        User.hr_administrator.each do |user|
          if (user.notification_settings.empty? ||
            user.notification_settings[:create_post] == Settings.serialize_true)
            create_notification user.id
          end
        end
      else
        User.all.each do |user|
          if (user.notification_settings.empty? ||
            user.notification_settings[:create_post] == Settings.serialize_true)
            create_notification user.id
          end
        end
      end
    when Answer.name
      if (self.trackable.post.user.notification_settings.empty? ||
        self.trackable.post.user.notification_settings[:reply_post] == Settings.serialize_true)
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
    end
  end

  def create_notification user_id
    self.notifications.create(user_id: user_id) if self.owner_id != user_id
  end
end
