class Answer < ApplicationRecord
  include PublicActivity::Model
  tracked only:[:create], owner: ->(controller, model){controller && controller.current_user}

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable,
    class_name: "PublicActivity::Activity", dependent: :destroy

  belongs_to :post
  belongs_to :user
end
