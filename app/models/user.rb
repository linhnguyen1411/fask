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
  has_many :users_work_spaces, dependent: :destroy
  has_many :work_spaces, through: :users_work_spaces
  has_many :topices_users, dependent: :destroy
  has_many :topics, through: :topices_users
  has_many :notifications, dependent: :destroy

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true

  scope :not_user_hiddent, -> {where.not id: Settings.id_user_hiddent}

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

  class << self
    def from_omniauth auth
      user = find_or_initialize_by email: auth.info.email
      if user.present?
        password = User.generate_unique_secure_token[0..9]
        user.name = auth.info.name
        user.position = auth.info.position.name if auth.info.position.present?
        user.remote_avatar_url = auth.info.avatar if auth.info.avatar.present?
        user.password = password if user.new_record?
        user.is_create_by_wsm = true if user.new_record?
        user.save
        user
      end
    end
  end
end
