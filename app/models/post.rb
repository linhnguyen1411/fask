class Post < ApplicationRecord
  include PublicActivity::Model
  tracked

  has_many :clips, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :follows, as: :followtable
  has_many :reactions, as: :reactiontable

  belongs_to :user
  belongs_to :work_space
  belongs_to :topic
end
