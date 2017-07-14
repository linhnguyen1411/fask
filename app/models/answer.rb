class Answer < ApplicationRecord
  include PublicActivity::Model
  tracked

  belongs_to :post

  has_many :follows, as: :followtable
  has_many :reactions, as: :reactiontable
end
