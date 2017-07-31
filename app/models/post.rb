class Post < ApplicationRecord
  include PublicActivity::Model
  tracked

  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :reactions, as: :reactiontable
  has_many :clips, class_name: Clip.name,
    foreign_key: :post_id, dependent: :destroy
  has_and_belongs_to_many :tags

  belongs_to :user
  belongs_to :work_space, optional: true
  belongs_to :topic
end
