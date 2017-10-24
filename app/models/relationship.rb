class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :following, class_name: User.name

  has_many :activities, as: :trackable, dependent: :destroy
  after_create :create_activity

  private

  def create_activity
    self.activities.create owner: self.follower, recipient: self.following
  end
end
