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

  scope :answers_of_post, -> post_id { where(post_id: post_id).includes(:user, :comments, :reactions)}
  scope :includes_post_and_topic_on, -> do
    eager_load(post: :topic).where "topics.status = true"
  end

  private

  def create_activity
    self.activities.create owner: self.user
  end

  def standardize_content
    content.remove!('<p>&nbsp;</p>');
  end
end
