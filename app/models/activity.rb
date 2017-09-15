class Activity < PublicActivity::Activity
  belongs_to :trackable, polymorphic: true

  has_many :notifications

  after_create :add_notification

  private

  def add_notification
    case self.trackable.class.name
    when Post.name
      self.owner.followers.each do |user|
        create_notification user.id
      end
    when Answer.name
      create_notification self.trackable.post.user_id
    when Comment.name
      create_notification  self.trackable.commentable.user_id
    when Reaction.name
      create_notification self.trackable.reactiontable.user_id
    end
  end

  def create_notification user_id
    self.notifications.create(user_id: user_id) if self.owner_id != user_id
  end
end
