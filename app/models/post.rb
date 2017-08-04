class Post < ApplicationRecord
  include PublicActivity::Model
  tracked

  paginates_per Settings.paginate_default

  acts_as_paranoid

  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :reactions, as: :reactiontable
  has_many :clips, class_name: Clip.name,
    foreign_key: :post_id, dependent: :destroy
  has_many :posts_tag, dependent: :destroy
  has_many :tags, through: :posts_tag

  belongs_to :user
  belongs_to :work_space, optional: true
  belongs_to :topic

  validates :title, presence: true,
    length: {maximum: Settings.post.max_title, minimum: Settings.post.min_title}
  validates :content, presence: true

  scope :get_post_by_topic, -> topic_id {where topic_id: topic_id}

  scope :newest, -> {order created_at: :desc}
end
