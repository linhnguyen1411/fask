class Post < ApplicationRecord
  paginates_per Settings.paginate_default

  acts_as_paranoid

  searchkick

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :clips, class_name: Clip.name,
    foreign_key: :post_id, dependent: :destroy
  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags
  has_many :activities, as: :trackable, dependent: :destroy
  has_many :a_versions, as: :a_versionable, dependent: :destroy

  belongs_to :user
  belongs_to :work_space, optional: true
  belongs_to :topic

  after_create :create_activity

  validates :title, presence: true,
    length: {maximum: Settings.post.max_title, minimum: Settings.post.min_title}
  validates :content, presence: true

  delegate :name, :position, :avatar, to: :user, prefix: true

  delegate :name, to: :topic, prefix: true

  delegate :name, to: :work_space, prefix: true

  scope :get_post_by_topic, -> topic_id {where topic_id: topic_id}

  scope :newest, -> {order created_at: :desc}

  scope :popular, -> {order count_view: :desc}

  scope :recently_answer, -> do
    joins(:answers).group("answers.post_id").order "answers.created_at desc"
  end

  scope :post_of_work_space, -> work_space_id { where work_space_id: work_space_id if work_space_id.present?}

  scope :no_answer, -> {includes(:answers).where(answers: {id: nil})}

  scope :recently_comment, -> do
    joins(:comments).group("comments.commentable_id").order "comments.created_at desc"
  end

  scope :by_tags, -> tag_id do
    joins(:posts_tags).where "posts_tags.tag_id = ?", tag_id
  end

  scope :list_posts_clip, ->post_ids{where(id: post_ids)}

  private

  def create_activity
    self.activities.create owner: self.user
  end

  def search_data
    attributes.merge(
      tag_name: tags.map(&:name),
      title: title,
      content: content,
      )
  end
end
