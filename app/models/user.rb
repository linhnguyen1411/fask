class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :topic_managers, dependent: :destroy
  has_many :topics, through: :topic_managers
  has_many :clips, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :follows, as: :followtable, dependent: :destroy
  has_many :answers, dependent: :destroy

  belongs_to :role, optional: true
  belongs_to :company, optional: true
end
