class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :topic, through: :manager_topics
  has_many :clips, dependent: :destroy
  has_many :manager_topics, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :follows, as: :followtable

  belongs_to :role, optional: true
  belongs_to :company, optional: true
end
