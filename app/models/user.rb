class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :manager_topics, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :follows, as: :followtable

  belongs_to :role
  belongs_to :company
end
