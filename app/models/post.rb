class Post < ApplicationRecord
  include PublicActivity::Model
  tracked

  paginates_per Settings.paginate_default

  acts_as_paranoid

  searchkick

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

  delegate :name, :position, :avatar, to: :user, prefix: true

  scope :get_post_by_topic, -> topic_id {where topic_id: topic_id}

  scope :newest, -> {order created_at: :desc}

  scope :popular, -> {order count_view: :desc}

  scope :recently_answer, -> {joins(:answers).group("answers.post_id").order("answers.created_at desc")}

  scope :no_answer, -> {includes(:answers).where(answers: {id: nil})}

  scope :recently_comment, -> {joins(:comments).group("comments.post_id").order("comments.created_at desc")}
end
