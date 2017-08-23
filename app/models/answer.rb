class Answer < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model){controller && controller.current_user}

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  has_many :comments
  has_many :reactions, as: :reactiontable

  belongs_to :post
  belongs_to :user
end
