class Answer < ApplicationRecord
  include PublicActivity::Model
  tracked

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  has_many :comments
  has_many :reactions, as: :reactiontable

  belongs_to :post
  belongs_to :user
end
