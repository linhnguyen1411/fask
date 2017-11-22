class Answer < ApplicationRecord

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy

  belongs_to :post
  belongs_to :user

  after_create :create_activity
  before_save :standardize_content

  private

  def create_activity
    self.activities.create owner: self.user
  end

  def standardize_content
    content.remove!('<p>&nbsp;</p>');
  end
end
