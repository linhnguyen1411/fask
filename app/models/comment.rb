class Comment < ApplicationRecord

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  after_create :create_activity

  scope :comments_of_post_before_time, -> post, view_more_time do
    (where "commentable_id = (?) and commentable_type= (?)and created_at <= (?)",
      post.id, post.class, view_more_time).order(created_at: :desc)
  end

  private

  def create_activity
    self.activities.create owner: self.user
  end
end
