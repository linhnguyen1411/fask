class Answer < ApplicationRecord
  include PublicActivity::Model
  tracked

  has_many :comments
  has_many :reactions, as: :reactiontable

  belongs_to :post
  belongs_to :user
end
