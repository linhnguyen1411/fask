class Post < ApplicationRecord
  include PublicActivity::Model
  tracked

  acts_as_paranoid

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
end
