class Comment < ApplicationRecord

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  after_create :create_activity

  private

  def create_activity
    self.activities.create owner: self.user
  end
end
