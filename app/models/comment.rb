class Comment < ApplicationRecord

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  after_save :create_activity

  scope :comments_of_post_before_time, -> post, view_more_time do
    (where "commentable_id = (?) and commentable_type= (?)and created_at <= (?)",
      post.id, post.class, view_more_time).includes(:user, :reactions).order(created_at: :desc)
  end
  scope :comments_of_post_in_topic_on, -> do
    joins("LEFT JOIN answers ON commentable_id = answers.id and commentable_type = 'Answer'")
    .joins("LEFT JOIN posts ON (commentable_id = posts.id and commentable_type = 'Post') or answers.post_id = posts.id ")
    .joins("JOIN topics ON topics.id = posts.topic_id").includes(:commentable).where("topics.status = true")
  end

  private

  def create_activity
    self.activities.create owner: self.user
  end
end
