class User < ApplicationRecord
  acts_as_paranoid

  serialize :notification_settings, Hash
  serialize :email_settings, Hash

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:framgia]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :clips, class_name: Clip.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :topices_users, dependent: :destroy
  has_many :topics, through: :topices_users
  has_many :notifications, dependent: :destroy
  has_many :a_versions

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower
  belongs_to :work_space

  validates :name, presence: true

  scope :not_user_hiddent, -> {where.not id: Settings.id_user_hiddent}
  scope :notify_feedback_for_position, -> do
    where position: [Settings.event_officer]
  end
  scope :position_allowed_answer_feedback, -> do
    where position: [Settings.event_officer]
  end

  mount_uploader :avatar, UserAvatarUploader

  scope :top_users, -> do
    joins(:answers).group("answers.user_id").order("count(answers.user_id) desc")
  end

  scope :get_activities, -> current_user do
    PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.id)
  end

  scope :get_users_not_contain_id, -> user_id {where.not(id: user_id)}

  scope :follow, -> current_user, user_id do
    current_user.active_relationships.new.update_attributes following_id: user_id
  end

  scope :unfollow, -> current_user, user_id do
    current_user.active_relationships.where(following_id: user_id).first.destroy
  end

  scope :check_follow, -> current_user, user_id do
    current_user.active_relationships.where(following_id: user_id).count
  end

  scope :previous_tagged_users_in_comment, -> comment do
    joins(notifications: :activity).where(
      "trackable_id = (?) and trackable_type = (?) and is_tag_user = true",
      comment.id, comment.class
    )
  end

  class << self
    def from_omniauth auth
      user = find_or_initialize_by email: auth.info.email
      if user.present?
        password = User.generate_unique_secure_token[0..9]
        user.name = auth.info.name
        user.position = auth.info.position.name if auth.info.position.present?
        user.remote_avatar_url = auth.info.avatar.gsub("http://", "https://") if auth.info.avatar.present?
        user.password = password if user.new_record?
        user.is_create_by_wsm = true if user.new_record?
        user.work_space_id = get_work_space_of_wsm_account_for_user(user,
          auth.info.workspaces, auth.info.workspace_default)
        SendPasswordMailer.send_password(user, password).deliver_now if user.new_record?
        user.language = Settings.languages.en
        user.save
        user
      end
    end

    def get_work_space_of_wsm_account_for_user user, work_spaces, workspace_default
      work_space_name_of_wsm_account = workspace_default.present? ? workspace_default : work_spaces.first.name
      work_space = WorkSpace.find_by name: work_space_name_of_wsm_account
      if work_space.present?
         work_space.id
      else
        create_work_space work_space_name_of_wsm_account
      end
    end

    def create_work_space work_space_name_of_wsm_account
      work_space = WorkSpace.new(
        name: work_space_name_of_wsm_account
      )
      work_space.save ? work_space.id : WorkSpace.first.id
    end

    def load_user user_id
      User.find_by id: user_id
    end
  end
end
