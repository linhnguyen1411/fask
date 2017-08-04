class User < ApplicationRecord
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :clips, class_name: Clip.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :users_work_spaces, dependent: :destroy
  has_many :work_spaces, through: :users_work_space
  has_many :topics_user, dependent: :destroy
  has_many :topics, through: :topics_user

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  scope :not_user_hiddent, -> {where.not id: Settings.id_user_hiddent}
end
