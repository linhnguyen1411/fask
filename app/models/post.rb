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
  belongs_to :category, optional: true

  before_save :standardize_content
  after_create :create_activity
  after_update :update_activity

  enum status: {waiting: 0, accept: 1, reject: 2}

  validates :title, presence: true,
    length: {maximum: Settings.post.max_title, minimum: Settings.post.min_title}
  validates :content, presence: true

  delegate :name, :position, :avatar, to: :user, prefix: true

  delegate :name, to: :topic, prefix: true

  delegate :name, to: :work_space, prefix: true

  delegate :name, to: :category, prefix: true, allow_nil: true

  scope :newest, -> {order created_at: :desc}

  scope :popular, -> {order count_view: :desc}

  scope :recently_answer, -> do
    order "max(answers.created_at) desc"
  end

  scope :no_answer, -> {where(answers: {id: nil})}

  scope :post_by_topic, -> topic_id do
    where(topic_id: topic_id).merge(post_includes_category topic_id)
    .merge(post_includes_work_space topic_id).accept.merge(post_full_includes)
  end

  scope :feedback_post, -> do
    where(topic_id: Settings.topic.feedback_number)
      .merge(post_includes_category(Settings.topic.feedback_number))
  end

  scope :post_of_work_space, -> work_space_id do
    where work_space_id: work_space_id if work_space_id.present?
  end

  scope :post_in_time, -> from_day, to_day do
    posts_after(from_day).merge(posts_before to_day)
  end

  scope :post_of_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :recently_comment, -> do
    joins(:comments).group("comments.commentable_id").order "max(comments.created_at) desc"
  end

  scope :by_tags, -> tag_id do
    joins(:posts_tags).where "posts_tags.tag_id = ?", tag_id
  end

  scope :list_posts_clip, -> post_ids do
    where(id: post_ids).merge(post_full_includes)
  end

  scope :post_full_includes, -> do
    joins("LEFT JOIN comments ON comments.commentable_id = posts.id and comments.commentable_type = 'Post'")
    .joins("LEFT JOIN answers ON answers.post_id = posts.id").group("posts.id")
    .group("posts.id").includes(:user, :tags, :reactions)
    .select("posts.*, count(answers.id) as count_answer, count(comments.id) as count_comment")
  end

  scope :not_contain_post, -> post_id do
    where.not(id: post_id)
  end

  scope :by_status, -> status do
    where(status: status) if status.present?
  end

  private

  scope :posts_after, -> from_day do
    where(" posts.created_at >= (?)", from_day) if from_day.present?
  end

  scope :posts_before, -> to_day do
    where(" DATE(posts.created_at) <= (?)", to_day) if to_day.present?
  end

  scope :post_includes_category, -> topic_id do
    includes(:category) if topic_id == Settings.topic.feedback
  end

  scope :post_includes_work_space, -> topic_id do
    includes(:work_space) if topic_id == Settings.topic.feedback
  end

  scope :post_by_category, -> category_id { where category_id: category_id if category_id.present?}

  def create_activity
    self.activities.create owner: self.user
  end

  def update_activity
    if self.status_changed?
      if self.status != Settings.version.waiting && self.user_id != Settings.anonymous_number
        self.activities.create owner: self.user, parameters: {status_changed: self.status}
      end
    end
  end

  def search_data
    attributes.merge(
      tag_name: tags.map(&:name),
      title: title,
      content: content,
      )
  end

  def standardize_content
    content.remove!('<p>&nbsp;</p>');
  end
end
