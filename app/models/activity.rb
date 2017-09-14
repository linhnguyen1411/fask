class Activity < PublicActivity::Activity
  belongs_to :trackable, polymorphic: true

  has_many :notifications

  after_create :create_notification

  private

  def create_notification
    case self.trackable.class.name
    when Post.name
      self.owner.followers.each do |user|
        self.notifications.create user_id: user.id
      end
    when Answer.name
      user_id = self.trackable.post.user_id
      self.notifications.create user_id: user_id
    when Comment.name
      self.notifications.create user_id: self.trackable.commentable.user_id
    when Reaction.name
      object = self.trackable.reactiontable
      self.notifications.create user_id: object.user_id
    end
  end
end
