class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactiontable, polymorphic: true

  has_many :activities, as: :trackable, dependent: :destroy

  enum target_type: {upvote: 0, downvote: 1, like: 2, dislike: 3, heart: 4}

  after_create :create_activity

  private

  def create_activity
    self.activities.create owner: self.user
  end
end
